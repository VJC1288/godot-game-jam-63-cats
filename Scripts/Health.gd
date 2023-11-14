extends Node2D

class_name HealthComponent


@export var max_health: int = 100

var current_health: int
var actor

func _ready():
	
	actor = get_parent()
	current_health = max_health


func set_health_to(new_value: int):
	current_health = new_value

func adjust_health(adjustment: int):
	current_health += adjustment
	print(current_health)
	if current_health <= 0:
		actor.die()
	
func get_health() -> int:
	return current_health
