extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var ray_cast_2d = $RayCast2D
@onready var sprite_2d = $Sprite2D


@export var damage_amount:int = 20

var actor
var recoil_speed = 450

func _ready():
	actor = get_parent()
	animation_player.play("RESET")
	ray_cast_2d.set_deferred("enabled", false)

func slash():
	animation_player.play("slash")
	ray_cast_2d.set_deferred("enabled", true)

func _on_animation_player_animation_finished(anim_name):
	if anim_name == "slash":
		ray_cast_2d.set_deferred("enabled", false)
		
func set_left():
	sprite_2d.position.x = -24
	ray_cast_2d.target_position.x = -29
	
func set_right():
	sprite_2d.position.x = 24
	ray_cast_2d.target_position.x = 29

func _process(delta):
	if ray_cast_2d.enabled == true:
		if ray_cast_2d.is_colliding():
			ray_cast_2d.set_deferred("enabled", false)
			var collider = ray_cast_2d.get_collider()
			if collider != null and collider.has_method("break_box"):
				collider.break_box()
