extends Node2D


class_name EagleBehavior


enum EnemyStates {IDLE, FLYING, DIVING, WAITING}

@onready var wall_detector = $"../WallDetector"
@onready var cliff_detector = $"../CliffDetector"
@onready var actor = $".."
@onready var sprite_2d = $"../Sprite2D"
@onready var animation_player = $"../AnimationPlayer"
@onready var player_detector = $"../PlayerDetector"
@onready var collision_shape_2d = $"../CollisionShape2D"


@export var cliff_rebounds: bool = true
@export var distance_limit: int = 150
@export var start_left: bool = false
@export var SPEED: int = 100

var currentState: EnemyStates
var direction: Vector2
var originX
var diveTarget
var diveSpeed = 400

func _ready():
	direction = Vector2(1,0)
	currentState = EnemyStates.FLYING
	originX = global_position.x
	if start_left:
		flip_char()
		
	

func _process(delta):
	
	
	match currentState:
	
		EnemyStates.IDLE:
			pass
			
		EnemyStates.FLYING:
			animation_player.play("moving")
			
			actor.velocity.x = direction.x * SPEED
			actor.velocity.y = sin(Time.get_ticks_msec()/100) * 25

			actor.move_and_slide()
			
			if abs(global_position.x - originX) > distance_limit:
				flip_char()
			

			
		EnemyStates.DIVING:
			animation_player.play("diving")
					
			actor.velocity = diveSpeed * direction
			
			actor.move_and_slide()
			
		EnemyStates.WAITING:
			pass
			
func flip_char():			
		direction *= -1		
		wall_detector.target_position.x *= -1
		cliff_detector.position.x *= -1
		sprite_2d.flip_h = !sprite_2d.flip_h


func _on_player_detector_body_entered(body):
	if body.is_in_group("player"):
		currentState = EnemyStates.DIVING
		diveTarget = body.global_position
		diveTarget.x += 20
		direction = global_position.direction_to(diveTarget).normalized()
		collision_shape_2d.set_deferred("disabled", true)
		player_detector.set_deferred("monitoring", false)
		
