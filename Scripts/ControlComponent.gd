extends Node2D

enum CatStates {IDLE, RUNNING, AIR, HURT}

@onready var animation_player = $"../AnimationPlayer"
@onready var sprite_2d = $"../Sprite2D"
@onready var hurt_timer = $HurtTimer



const SPEED = 300.0
const JUMP_VELOCITY = -600.0

var actor
var current_state

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	
	actor = get_parent()
	
	current_state = CatStates.AIR



func _physics_process(delta):
	
	#print(current_state)
	match current_state:
		
		CatStates.IDLE:
			
			actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.15)
			
			animation_player.play("idle")
			
			if not actor.is_on_floor():
				current_state = CatStates.AIR
						
			if Input.is_action_just_pressed("p1_jump") and actor.is_on_floor():
				actor.velocity.y = JUMP_VELOCITY
				current_state = CatStates.AIR
				return
			
			if Input.get_axis("p1_left", "p1_right") != 0:
				current_state = CatStates.RUNNING
				return
			
			actor.move_and_slide()

		CatStates.RUNNING:
			
			animation_player.play("running")
			
			var direction = Input.get_axis("p1_left", "p1_right")

			if direction < 0:
				sprite_2d.flip_h = true

			elif direction > 0:
				sprite_2d.flip_h = false
			
			if not actor.is_on_floor():
				current_state = CatStates.AIR
				return
			

			if Input.is_action_just_pressed("p1_jump") and actor.is_on_floor():
				actor.velocity.y = JUMP_VELOCITY
				current_state = CatStates.AIR
				return
				
			if direction:		
				actor.velocity.x = lerp(actor.velocity.x, direction * SPEED, 0.3)
			else:
				actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.3)
				current_state = CatStates.IDLE

			
			actor.move_and_slide()
	
		CatStates.AIR:
			
			if actor.is_on_floor():
				current_state = CatStates.IDLE
				return
			
			if actor.velocity.y > 0:
				actor.velocity.y += gravity * delta
				animation_player.play("jump_down")
			else:
				actor.velocity.y += gravity * delta * 2
				animation_player.play("jump_up")
				
			var direction = Input.get_axis("p1_left", "p1_right")
			if direction < 0:
				sprite_2d.flip_h = true

			elif direction > 0:
				sprite_2d.flip_h = false
			
			if direction:		
				actor.velocity.x = lerp(actor.velocity.x, direction * SPEED, 0.1)
			else:
				actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.1)
				
			actor.move_and_slide()
			
		CatStates.HURT:

			if hurt_timer.is_stopped():
				var tween = create_tween()
				tween.set_trans(Tween.TRANS_LINEAR)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.2), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.7), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.2), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.7), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.2), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.7), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.2), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.7), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 0.2), 0.1)
				tween.tween_property(sprite_2d, "modulate", Color(1, 1, 1, 1), 0.1)
				hurt_timer.start()

			
			if actor.velocity.y > 0:
				actor.velocity.y += gravity * delta
				animation_player.play("jump_down")
			else:
				actor.velocity.y += gravity * delta * 2
				animation_player.play("jump_up")
			
			if actor.is_on_floor():
				animation_player.play("idle")
			

			actor.move_and_slide()

func set_state(new_state: int):
	current_state = new_state



func _on_hurt_timer_timeout():

	set_state(CatStates.IDLE)
