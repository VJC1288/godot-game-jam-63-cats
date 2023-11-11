extends Node2D


@onready var cat_player = $CatPlayer
@onready var game_camera = %GameCamera


# Called when the node enters the scene tree for the first time.
func _ready():
	game_camera.initialize(cat_player)
