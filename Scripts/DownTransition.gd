extends Area2D


@onready var game_camera = %GameCamera
@onready var cat_player = $"../../../CatPlayer"
@onready var destination_marker = $DestinationMarker



func _on_body_entered(body):
	if body.is_in_group("player"):
		game_camera.global_position.y += 32*20
		cat_player.global_position = destination_marker.global_position
