extends Node2D

@export var player: CharacterBody2D

func initialize():
	for i in get_children():
		i.connect("new_respawn", set_new_respawn)
		

func set_new_respawn(new_respawn):
	player.set_respawn(new_respawn)
