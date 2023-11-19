extends Control

@onready var margin_container = $ColorRect/MarginContainer
@onready var title_screen = preload("res://Scenes/titlescreen.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	margin_container.modulate = Color(1,1,1,0)
	margin_container.visible = true
	
	var tween = get_tree().create_tween()
	tween.tween_property(margin_container, "modulate", Color(1,1,1,1), 4)


func _on_restart_button_pressed():
	get_tree().change_scene_to_packed(title_screen)
