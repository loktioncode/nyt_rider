extends CharacterBody2D

# Add these signals
signal attack_started
signal attack_ended
signal death_animation_finished

@export var killzone: Area2D 
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

var player_damage_received = 0
const SPEED = 130.0
const JUMP_VELOCITY = -250.0
var is_attacking = false
var is_dead = false  # Add this flag to track death state

var health = 100      # Optional: add health system

func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)
	# Add player to group so killzone can find it
	add_to_group("player")
	
func _physics_process(delta: float) -> void:
	if is_dead:
		return  # Don't process any movement if dead
		
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("attack") and is_on_floor():
		is_attacking = true
		attack_started.emit()  # Emit signal instead of direct call
		animated_sprite.play("attack")

	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_attacking:
		pass
	elif is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func _on_animation_finished():
	if animated_sprite.animation == "attack":
		is_attacking = false
		attack_ended.emit()  # Emit signal instead of direct call

func take_damage(amount) -> void:
	if is_dead:
		return  # Don't take damage if already dead
		
	player_damage_received += amount  # Increment damage counter
	health -= amount       # Optional: subtract from health
	
	#update global damage
	game_manager.track_player_damage(amount)
	animated_sprite.play("hit")
	if health <= 0:
		die()
	print("Player damage taken:", amount)
	print("Player total damage:", player_damage_received)
	print("Player health remaining:", health)
	
func die() -> void:
	if is_dead:
		return  # Don't die again if already dead
		
	is_dead = true
	print("Player died! Total damage taken:", player_damage_received)
	
	# Stop horizontal movement but keep vertical movement for falling
	velocity.x = 0
	
	# If not on floor, wait until player hits the ground
	if not is_on_floor():
		# Let gravity pull the player down
		while not is_on_floor():
			velocity.y += get_gravity().y * get_physics_process_delta_time()
			move_and_slide()
			await get_tree().physics_frame
	
	# Now play die animation (guaranteed to be on floor)
	animated_sprite.play("die")
	
	# Wait for animation to finish
	await animated_sprite.animation_finished
	death_animation_finished.emit()
