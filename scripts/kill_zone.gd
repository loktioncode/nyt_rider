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

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()

func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
