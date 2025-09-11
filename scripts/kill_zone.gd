extends Area2D

@onready var timer = $Timer
@onready var collision_shape = $CollisionShape2D  # Reference to collision shape

# Signal approach - connect to player signals
func _ready():
	# Find player and connect to its signals
	var player = get_tree().get_first_node_in_group("player")  # You'll need to add player to "player" group
	if player:
		# Connect if player has these signals
		if player.has_signal("attack_started"):
			player.attack_started.connect(disable_killzone)
		if player.has_signal("attack_ended"):
			player.attack_ended.connect(enable_killzone)

func disable_killzone():
	collision_shape.disabled = true

func enable_killzone():
	collision_shape.disabled = false

# Alternative: Wait for animation to finish before cleanup
# When player enters killzone
func _on_body_entered(body: Node2D) -> void:
	# Make sure we're only affecting the player
	if not body.is_in_group("player"):
		return
	
	# Get reference to player script
	var player = body
	
	# Check if player has the die function
	if player.has_method("die"):
		Engine.time_scale = 0.5
		player.die()  # Call the player's die function
		
		# Connect to death animation finished signal if available
		if player.has_signal("death_animation_finished"):
			await player.death_animation_finished
		else:
			# Fallback: wait for a fixed time
			await get_tree().create_timer(1.0).timeout
		
		timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
