extends Node


var score = 0
@onready var score_label = $ScoreLabel
var total_player_damage = 0
var total_enemy_damage = 0

func _ready():
	# Connect to player and enemy damage signals
	var player = get_tree().get_first_node_in_group("player")
	var enemies = get_tree().get_nodes_in_group("enemies")
	
	if player:
		player.connect("damage_taken", track_player_damage)
	
	for enemy in enemies:
		enemy.connect("damage_taken", track_enemy_damage)

func track_player_damage(amount):
	total_player_damage += amount
	print("Global player damage:", total_player_damage)

func track_enemy_damage(amount):
	total_enemy_damage += amount
	print("Global enemy damage:", total_enemy_damage)
	
func add_point():
	score +=1
	score_label.text = "You collected " + str(score) + " coins."
