extends Node


var score = 0
@onready var score_label = $ScoreLabel
var total_player_damage = 0
var total_enemy_damage = 0

func track_player_damage(amount):
	total_player_damage += amount
	print("Global player damage:", total_player_damage)

func track_enemy_damage(amount):
	total_enemy_damage += amount
	print("Global enemy damage:", total_enemy_damage)
	
func add_point():
	score +=1
	score_label.text = "You collected " + str(score) + " coins."
	print("coins", score)
	
