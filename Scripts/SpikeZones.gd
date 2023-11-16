extends Area2D


@export var damage_amount = 20


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_area_entered(area):
	if area.has_method("damage"):
		area.damage(damage_amount, global_position)
		

