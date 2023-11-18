extends Node2D

@export var player: CharacterBody2D

func initialize():
	for i in get_children():
		i.connect("new_respawn", set_new_respawn)
		

func set_new_respawn(new_respawn, respawn_node):
	player.set_respawn(new_respawn)
	for i in get_children():
		if i != respawn_node:
			i.animation_player.play("RESET")
			i.trigger_area.set_deferred("monitoring", true)
