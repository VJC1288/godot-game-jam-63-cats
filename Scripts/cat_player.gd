extends CharacterBody2D

class_name Player

var recoil_speed = 400

@onready var hit_box_component = $HitBoxComponent
@onready var animation_player = $AnimationPlayer
@onready var control_component = $ControlComponent
@onready var health_component = $HealthComponent

var current_respawn
var max_lives = 9
var current_lives

func _ready():
	
	hit_box_component.connect("took_damage", take_damage)
	animation_player.play("RESET")
	current_respawn = global_position
	current_lives = max_lives	

func take_damage(from_direction):
	control_component.set_state(3)
	velocity += global_position.direction_to(from_direction).normalized() * recoil_speed * -1 
		
func _process(delta):
	pass
		
	
func set_respawn(new_respawn):
	current_respawn = new_respawn

func die():
	current_lives -= 1
	control_component.respawn(current_respawn)
	health_component.set_health_to(100)

