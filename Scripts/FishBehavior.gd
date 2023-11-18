extends Node2D

class_name FishyBehavior

enum EnemyStates {IDLE, DIVING_UP, DIVING_DOWN, WAITING}

@onready var actor = $".."
@onready var sprite_2d = $"../Sprite2D"
@onready var animation_player = $"../AnimationPlayer"
@onready var player_detector = $"../PlayerDetector"
@onready var collision_shape_2d = $"../CollisionShape2D"
@onready var jump_timer = $JumpTimer


@export var cliff_rebounds: bool = true
@export var distance_limit: int = 150

@export var SPEED: int = 100
@export var JUMP_VELOCITY: int = 600

var currentState: EnemyStates
var direction: Vector2
var originX
var originY
var diveTarget
var diveSpeed = 400
var start_left: bool = false

func _ready():
	direction = Vector2(0,-1)
	currentState = EnemyStates.IDLE
	originX = global_position.x
	originY = global_position.y


func _process(delta):
	

	match currentState:
	
		EnemyStates.IDLE:
			pass
			
		EnemyStates.DIVING_UP:
			if animation_player.is_playing():
				pass
			else:
				animation_player.play("biting")
				
			actor.velocity.y += actor.gravity * delta
					
			if actor.velocity.y >= 5:
				currentState = EnemyStates.DIVING_DOWN
				animation_player.play("turning")		
			
			actor.move_and_slide()
			

			
		EnemyStates.DIVING_DOWN:
			
			if animation_player.is_playing():
				pass
			else:
				animation_player.play("biting")
				sprite_2d.flip_v = true
			
			actor.velocity.y += actor.gravity * delta
			
			actor.move_and_slide()
						
			if actor.global_position.y >= originY:
				animation_player.play("entering_water")
				sprite_2d.flip_v = false
				currentState = EnemyStates.IDLE
				
				
		EnemyStates.WAITING:
			pass
			

func _on_player_detector_body_entered(body):
	jump_timer.start()
	currentState = EnemyStates.DIVING_UP
	animation_player.play("leaving_water")
	actor.velocity.y = direction.y * JUMP_VELOCITY
	player_detector.set_deferred("monitoring", false)


func _on_jump_timer_timeout():
	player_detector.set_deferred("monitoring", true)
	


