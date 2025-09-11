extends Node2D

const SPEED = 60
# left -1, right 1
var direction = 1
var slime_damage_received = 0  # Add damage counter
var is_dying = false  # Track if the slime is dying

@onready var game_manager = %GameManager
@onready var ray_cast_right = $RayCastRight
@onready var ray_cast_left = $RayCastLeft
@onready var animated_sprite = $AnimatedSprite2D
@onready var collision_shape = $kill_zone/CollisionShape2D

func _ready():
	# Connect the animation_finished signal
	animated_sprite.animation_finished.connect(_on_animation_finished)

func _process(delta: float):
	if is_dying:
		return  # Don't process movement if dying
		
	if ray_cast_right.is_colliding():
		direction = -1
		animated_sprite.flip_h = true
	if ray_cast_left.is_colliding():
		direction = 1
		animated_sprite.flip_h = false
		
	position.x += direction * delta * SPEED

func take_damage(amount) -> void:
	if is_dying:
		return  # Don't take damage if already dying
		
	slime_damage_received += amount  # Increment damage counter
	animated_sprite.play("hit")
	if slime_damage_received >= 2:  # Use >= for safety
		die()

func die() -> void:
	is_dying = true
	animated_sprite.play("die")
	
	# Disable collisions
	if collision_shape:
		collision_shape.set_deferred("disabled", true)
	
	# Optionally disable raycasts to prevent movement
	ray_cast_right.enabled = false
	ray_cast_left.enabled = false
	
	# Update global damage
	game_manager.track_enemy_damage(slime_damage_received)

func _on_animation_finished():
	# Check if the finished animation was the "die" animation
	if animated_sprite.animation == "die":
		# Remove the slime from the scene
		queue_free()
