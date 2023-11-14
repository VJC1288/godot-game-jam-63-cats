extends Camera2D


var player_to_follow

var game_width
var game_height
var game_scale = 3

var camera_offset_x
var camera_offset_y

func _ready():
	game_width = get_window().size.x
	game_height = get_window().size.y
	
	
	camera_offset_x = game_width / 2 / game_scale
	camera_offset_y = game_height / 2 / game_scale
	
	global_position.x = camera_offset_x
	global_position.y = camera_offset_y
	

func initialize(player: CharacterBody2D):
	player_to_follow = player


func _process(delta):
	
	if player_to_follow != null:
		global_position.x = int(player_to_follow.global_position.x / (camera_offset_x * 2)) * 2 * camera_offset_x + camera_offset_x
	
