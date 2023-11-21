extends Control


@onready var help_box = %HelpBox
@onready var close_help = %CloseHelp

func _ready():
	help_box.visible = false
	

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(Globals.maingame)
	

func _on_help_button_pressed():
	help_box.visible = true


func _on_close_help_pressed():
	help_box.visible = false
