extends Area2D

@onready var animation_player = $"../ClawHurtbox/AnimationPlayer"


@export var damage_amount:int = 20

var actor
var recoil_speed = 200

func _ready():
	actor = get_parent()


func _on_area_entered(area):
	
	if area.has_method("damage"):
		area.damage(damage_amount, global_position)
		if actor.is_in_group("player"):
			actor.velocity = global_position.direction_to(area.global_position).normalized() * recoil_speed * -1 
