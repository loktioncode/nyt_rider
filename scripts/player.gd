extends CharacterBody2D

# Add these signals
signal attack_started
signal attack_ended

@export var killzone: Area2D 
@onready var animated_sprite = $AnimatedSprite2D
@onready var game_manager = %GameManager

const SPEED = 130.0
const JUMP_VELOCITY = -250.0
var is_attacking = false
var damage_taken = 0  # Add damage counter
var health = 100      # Optional: add health system

func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)
	# Add player to group so killzone can find it
	add_to_group("player")
	
func _physics_process(delta: float) -> void:
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
	damage_taken += amount  # Increment damage counter
	health -= amount       # Optional: subtract from health
	
	#update global damage
	game_manager.track_player_damage(amount)
	
	animated_sprite.play("hit")
	if health <= 0:
		die()
	print("Player damage taken:", amount)
	print("Player total damage:", damage_taken)
	print("Player health remaining:", health)
	
func die() -> void:
	print("Player died! Total damage taken:", damage_taken)
	# Add death logic here
	animated_sprite.play("death")
