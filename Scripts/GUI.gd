extends Control


@onready var life_bar = %LifeBar
@onready var lives = %Lives

var max_lives

func initialize(passed_player):
	passed_player.health_component.max_health = life_bar.max_value



func update_health_bar(new_value):
	life_bar.value = new_value


func update_lives_label(new_value):
	lives.text = "Lives: " + str(new_value)
