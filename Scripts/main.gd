extends Node2D


@onready var cat_player = $CatPlayer
@onready var game_camera = %GameCamera
@onready var save_point_manager = $SavePointManager
@onready var gui = $GUI
@onready var tomb_text = $"Level 1/TombText"
@onready var fade_to_black = $GUI/FadeToBlack
@onready var game_over_screen = preload("res://Scenes/game_over_screen.tscn")
@onready var victory_screen = preload("res://Scenes/victory_screen.tscn")

var arrow_key_buffer := []
var tomb_text_shown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	game_camera.initialize(cat_player)
	save_point_manager.initialize()
	gui.initialize(cat_player)
	cat_player.health_component.connect("health_changed", update_health_bar)
	cat_player.connect("lives_changed", respawn)
	cat_player.connect("game_over", game_over)
	
func _process(delta):
	
	gui.global_position = game_camera.global_position + Vector2(-256, -144)
		
	if  Input.is_action_just_pressed("secret_up"):
		arrow_key_buffer.push_back("up")
	elif  Input.is_action_just_pressed("secret_down"):
		arrow_key_buffer.push_back("down")
	elif  Input.is_action_just_pressed("secret_left"):
		arrow_key_buffer.push_back("left")
	elif  Input.is_action_just_pressed("secret_right"):
		arrow_key_buffer.push_back("right")
		
	if arrow_key_buffer.size() == 7:
		arrow_key_buffer.remove_at(0)


	if arrow_key_buffer == ["left", "left", "left", "left", "left", "left"]:
		cat_player.change_cat("Landon")
		arrow_key_buffer.clear()
	elif arrow_key_buffer == ["up", "down", "left", "right", "right", "up"]:
		cat_player.change_cat("Dewey")
		arrow_key_buffer.clear()
	elif arrow_key_buffer == ["down", "down", "left", "up", "right", "right"]:
		cat_player.change_cat("Barney")
		arrow_key_buffer.clear()
	elif arrow_key_buffer == ["left", "up", "down", "left", "up", "down"]:
		cat_player.change_cat("Shadow")
		arrow_key_buffer.clear()
		if tomb_text_shown == false:
			var tween = get_tree().create_tween()
			tween.tween_property(tomb_text, "modulate", Color(1,1,1, 0.25), 15)
			tomb_text_shown = true
		
	
func update_health_bar(new_health):
	gui.update_health_bar(new_health)

func respawn(new_lives):
	gui.update_lives_label(new_lives)
	print(new_lives)
	if new_lives != 0:
		fade_to_black.modulate = Color(0,0,0,0)
		fade_to_black.visible = true
		var tween = get_tree().create_tween()
		tween.tween_property(fade_to_black, "modulate", Color(0,0,0,1), 0)
		tween.tween_property(fade_to_black, "modulate", Color(0,0,0,0), 1.5)
		tween.tween_callback(hide_fade_to_black)
		

func game_over():
	fade_to_black.modulate = Color(0,0,0,0)
	fade_to_black.visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(fade_to_black, "modulate", Color(0,0,0,1), 3)
	tween.tween_callback(game_over_transition)

func game_over_transition():
	get_tree().change_scene_to_packed(game_over_screen)
	
func change_to_victory_screen():
	get_tree().change_scene_to_packed(victory_screen)	

func hide_fade_to_black():
	fade_to_black.visible = false


func _on_win_area_body_entered(body):
	if body.is_in_group("player"):
		cat_player.control_component.set_state(5)
		fade_to_black.visible = true
		fade_to_black.modulate = Color(0, 0, 0, 0)
		var tween = get_tree().create_tween()
		tween.tween_property(fade_to_black, "modulate", Color(0,0,0,1), 10)
		tween.tween_callback(change_to_victory_screen)
