extends Control

@onready var maingame: PackedScene = preload("res://Scenes/main.tscn")

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(maingame)
