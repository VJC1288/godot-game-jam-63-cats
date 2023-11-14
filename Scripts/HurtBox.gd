extends Area2D



@export var damage_amount:int = 20


func _on_area_entered(area):
	
	if area.has_method("damage"):
		area.damage(damage_amount, global_position)
	
