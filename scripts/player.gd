extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -250.0
var is_attacking = false

@onready var animated_sprite = $AnimatedSprite2D

func _ready():
	animated_sprite.animation_finished.connect(_on_animation_finished)
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	
	if Input.is_action_just_pressed("attack") and is_on_floor():
		is_attacking = true
		animated_sprite.play("attack")  # Change from "jump" to "attack"

	#gets input direction -1,0,1
	#flips player to face left/right
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if is_attacking:
		# Don't change animation if we're already attacking
		pass
	#Playing animations
	elif is_on_floor():
		if direction  == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	#Apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
	
func _on_animation_finished():
	if animated_sprite.animation == "attack":
		is_attacking = false
	
	
