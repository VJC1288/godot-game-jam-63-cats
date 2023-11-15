extends Node2D

class_name MoleManBehavior


enum EnemyStates {IDLE, WALKING, FLYING, CHASING, WAITING}

@onready var wall_detector = $"../WallDetector"
@onready var cliff_detector = $"../CliffDetector"
@onready var actor = $".."
@onready var sprite_2d = $"../Sprite2D"
@onready var animation_player = $"../AnimationPlayer"


@export var cliff_rebounds: bool = true
@export var distance_limit: int = 400
@export var start_left: bool = false
@export var SPEED: int = 100

var currentState: EnemyStates
var direction: int
var originX

func _ready():
	direction = 1
	currentState = EnemyStates.IDLE
	originX = global_position.x
	if start_left:
		flip_char()
		
	

func _process(delta):
	
	
	match currentState:
	
		EnemyStates.IDLE:
			if actor.is_on_floor():
				currentState = EnemyStates.WALKING
			else:
				actor.velocity.y += actor.gravity * delta	
			
			actor.move_and_slide()
			
		EnemyStates.WALKING:
			
			animation_player.play("moving")
			
			if cliff_detector.is_colliding():
				actor.velocity.x = direction * SPEED
			elif not cliff_detector.is_colliding() and cliff_rebounds:
				flip_char()
				
			if wall_detector.is_colliding():
				flip_char()
				
			actor.velocity.y += actor.gravity * delta	
			actor.move_and_slide()
			
			
		EnemyStates.FLYING:
			pass
			
		EnemyStates.CHASING:
			pass
			
		EnemyStates.WAITING:
			pass
			
func flip_char():			
		direction *= -1		
		wall_detector.target_position.x *= -1
		cliff_detector.position.x *= -1
		sprite_2d.flip_h = !sprite_2d.flip_h
