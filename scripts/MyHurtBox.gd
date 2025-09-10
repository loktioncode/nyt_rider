class_name MyHurtBox
extends Area2D

@export var damage := 0

func _init() -> void:
	collision_layer = 0
	collision_mask = 2

func _ready() -> void:
	connect("area_entered", Callable(self, "_on_area_entered"))

func _on_area_entered(hitbox: MyHitBox)-> void:
	if hitbox == null:
		return
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)
