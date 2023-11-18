extends Area2D

@onready var animation_player = $AnimationPlayer
@onready var collision_shape_2d = $CollisionShape2D


func _ready():
	animation_player.play("RESET")

func _on_area_entered(area):
	animation_player.play("reveal")
	collision_shape_2d.set_deferred("disabled", true)
