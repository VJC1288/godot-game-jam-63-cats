extends RigidBody2D

@onready var sprite_2d = $Sprite2D

var hits_left = 4

func break_box():
	hits_left -= 1
	if hits_left == 0:
		queue_free()
	sprite_2d.frame += 1
