extends Node2D

signal new_respawn(location: Vector2, respawn_point)

@onready var respawn_point = $RespawnPoint
@onready var animation_player = $AnimationPlayer
@onready var trigger_area = $TriggerArea

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_trigger_area_body_entered(body):
	if body.is_in_group("player"):
		animation_player.play("unfurl")
		emit_signal("new_respawn", respawn_point.global_position, self)
		trigger_area.set_deferred("monitoring", false)
		
