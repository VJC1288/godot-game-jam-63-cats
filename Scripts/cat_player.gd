extends CharacterBody2D

class_name Player

var recoil_speed = 400

@onready var hit_box_component = $HitBoxComponent
@onready var animation_player = $AnimationPlayer
@onready var control_component = $ControlComponent


func _ready():
	
	hit_box_component.connect("took_damage", take_damage)
	animation_player.play("RESET")

			

func take_damage(from_direction):
	control_component.set_state(3)
	velocity += global_position.direction_to(from_direction).normalized() * recoil_speed * -1 
	

func die():
	queue_free()
