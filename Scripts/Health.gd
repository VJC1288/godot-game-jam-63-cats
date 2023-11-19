extends Node2D

class_name HealthComponent

signal health_changed(new_health)

@export var max_health: int = 100

var current_health: int
var actor

func _ready():
	
	actor = get_parent()
	current_health = max_health
	emit_signal("health_changed", current_health)


func set_health_to(new_value: int):
	current_health = new_value
	emit_signal("health_changed", current_health)

	
func adjust_health(adjustment: int):
	current_health += adjustment
	if current_health <= 0:
		actor.die()
	emit_signal("health_changed", current_health)
	
func reset_health():
	set_health_to(max_health)
	
func get_health() -> int:
	return current_health
