extends Camera2D


var player_to_follow

var game_width
var game_height
var game_scale = 3

var camera_offset_x
var camera_offset_y

func _ready():
	game_width = get_viewport().get_visible_rect().size.x
	game_height = get_viewport().get_visible_rect().size.y

	
	camera_offset_x = game_width
	camera_offset_y = game_height
	
	
	global_position.x = camera_offset_x
	global_position.y = camera_offset_y / 2
	

func initialize(player: CharacterBody2D):
	player_to_follow = player


func _process(delta):
	
	if player_to_follow != null:

		if player_to_follow.global_position.x > 0:
			global_position.x = int(player_to_follow.global_position.x / camera_offset_x) * (camera_offset_x) + camera_offset_x / 2
		elif player_to_follow.global_position.x < 0:
			global_position.x = int(player_to_follow.global_position.x / camera_offset_x) * (camera_offset_x) - camera_offset_x / 2

