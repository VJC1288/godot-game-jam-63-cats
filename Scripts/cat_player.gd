extends CharacterBody2D

enum CatStates {IDLE, RUNNING, AIR, HURT}

@onready var sprite_2d = $Sprite2D
@onready var animation_player = $AnimationPlayer

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var current_state


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	current_state = CatStates.AIR

func _physics_process(delta):
	
	match current_state:
		
		CatStates.IDLE:
			
			if velocity.x != 0:
				current_state = CatStates.RUNNING
			
			animation_player.play("idle")
			
			if Input.is_action_just_pressed("p1_jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				current_state = CatStates.AIR
				return
			
			if Input.get_axis("p1_left", "p1_right") != 0:
				current_state = CatStates.RUNNING
				return
			
			move_and_slide()

		CatStates.RUNNING:
			
			animation_player.play("running")
			
			var direction = Input.get_axis("p1_left", "p1_right")

			if direction < 0:
				sprite_2d.flip_h = true

			elif direction > 0:
				sprite_2d.flip_h = false
			
			if not is_on_floor():
				current_state = CatStates.AIR
				return
			
			if direction == 0:
				current_state = CatStates.IDLE

			if Input.is_action_just_pressed("p1_jump") and is_on_floor():
				velocity.y = JUMP_VELOCITY
				current_state = CatStates.AIR
				return
				
			velocity.x = direction * SPEED
			
			move_and_slide()
	
		CatStates.AIR:
			if velocity.y > 0:
				velocity.y += gravity * delta
				animation_player.play("jump_down")
			else:
				velocity.y += gravity * delta * 2
				animation_player.play("jump_up")
				
			var direction = Input.get_axis("p1_left", "p1_right")
			if direction < 0:
				sprite_2d.flip_h = true

			elif direction > 0:
				sprite_2d.flip_h = false
					
			velocity.x = direction * SPEED
				
			move_and_slide()
			
			if is_on_floor():
				current_state = CatStates.IDLE
				return
					
