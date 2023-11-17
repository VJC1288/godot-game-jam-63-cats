@tool

extends Node

var player

# Called when the node enters the scene tree for the first time.
func _process(delta):
	if Input.is_action_just_pressed("move_player"):
		print("player_moved")
