extends Node2D


class_name EagleBehavior


enum EnemyStates {IDLE, FLYING, DIVING, WAITING}

@onready var wall_detector = $"../WallDetector"
@onready var cliff_detector = $"../CliffDetector"
@onready var actor = $".."
@onready var sprite_2d = $"../Sprite2D"


@export var cliff_rebounds: bool = true
@export var distance_limit: int = 150
@export var start_left: bool = false
@export var SPEED: int = 100

var currentState: EnemyStates
var direction: int
var originX

func _ready():
	direction = 1
	currentState = EnemyStates.FLYING
	originX = global_position.x
	if start_left:
		flip_char()
		
	

func _process(delta):
	
	
	match currentState:
	
		EnemyStates.IDLE:
			pass
			
		EnemyStates.FLYING:

			actor.velocity.x = direction * SPEED
			
			actor.move_and_slide()
			
			
			
			if abs(global_position.x - originX) > distance_limit:
				flip_char()
			

			
		EnemyStates.DIVING:
			pass
			
		EnemyStates.WAITING:
			pass
			
func flip_char():			
		direction *= -1		
		wall_detector.target_position.x *= -1
		cliff_detector.position.x *= -1
		sprite_2d.flip_h = !sprite_2d.flip_h
