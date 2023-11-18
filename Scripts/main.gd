extends Node2D


@onready var cat_player = $CatPlayer
@onready var game_camera = %GameCamera
@onready var save_point_manager = $SavePointManager

var arrow_key_buffer := []

# Called when the node enters the scene tree for the first time.
func _ready():
	game_camera.initialize(cat_player)
	save_point_manager.initialize()

func _process(delta):
	
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


	if arrow_key_buffer == ["up", "up", "up", "up", "up", "up"]:
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



