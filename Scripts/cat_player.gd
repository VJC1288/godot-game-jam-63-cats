extends CharacterBody2D

class_name Player

signal lives_changed(new_lives)

var recoil_speed = 400

@onready var hit_box_component = $HitBoxComponent
@onready var animation_player = $AnimationPlayer
@onready var control_component = $ControlComponent
@onready var health_component = $HealthComponent
@onready var sprite_2d = $Sprite2D

@onready var landon_texture = preload("res://Assets/Landon_Sprites.png")
@onready var dewey_texture = preload("res://Assets/Dewey_Sprites.png")
@onready var barney_texture = preload("res://Assets/Barney_Sprites.png")
@onready var shadow_texture = preload("res://Assets/catanimation-Sheet.png")

var current_respawn
@export var max_lives = 9
var current_lives


func _ready():
	
	hit_box_component.connect("took_damage", take_damage)
	animation_player.play("RESET")
	current_respawn = global_position
	current_lives = max_lives
	emit_signal("lives_changed", current_lives)

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
	health_component.reset_health()
	emit_signal("lives_changed", current_lives)

func change_cat(name:String):
	if name == "Landon":
		sprite_2d.texture = landon_texture
		control_component.can_double_jump = false
		control_component.can_scratch = false
		
	elif name == "Dewey":
		sprite_2d.texture = dewey_texture
		control_component.can_double_jump = false
		control_component.can_scratch = true
		
	elif name == "Barney":
		sprite_2d.texture = barney_texture
		control_component.can_double_jump = true
		control_component.can_scratch = false
		
	elif name == "Shadow":
		sprite_2d.texture = shadow_texture
		control_component.can_double_jump = true
		control_component.can_scratch = true
