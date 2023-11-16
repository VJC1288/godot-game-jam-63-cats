extends Node2D

class_name HitBoxComponent

signal took_damage(from_direction)

@export var health_component: HealthComponent



var actor: Node2D

func _ready():
	
	actor = get_parent()


func damage(damage_value, recoil_from):
	emit_signal("took_damage", recoil_from)
	health_component.adjust_health(-damage_value)

	
