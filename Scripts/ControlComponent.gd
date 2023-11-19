extends Node2D

enum CatStates {IDLE, RUNNING, AIR, HURT, RESPAWNING, VICTORY_RUN}

@onready var animation_player = $"../AnimationPlayer"
@onready var sprite_2d = $"../Sprite2D"
@onready var hurt_timer = $HurtTimer
@onready var claw_hurt_cast = $"../ClawHurtCast"
@onready var hit_box_component = $"../HitBoxComponent"




const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var actor: CharacterBody2D
var current_state
var jump_released = false
var can_double_jump = false
var double_jumped = false
var can_scratch = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	
	actor = get_parent()
	
	current_state = CatStates.AIR



func _physics_process(delta):
		
	match current_state:
		
		
		CatStates.IDLE:
		
			actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.20)
			
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
			
			if Input.is_action_just_pressed("p1_action") and can_scratch == true:
				actor.play_slash_noise()
				claw_hurt_cast.slash()
				
			
			actor.move_and_slide()

		CatStates.RUNNING:
			
			animation_player.play("running")
			
			var direction = Input.get_axis("p1_left", "p1_right")

			if direction < 0:
				sprite_2d.flip_h = true
				claw_hurt_cast.set_left()

			elif direction > 0:
				sprite_2d.flip_h = false
				claw_hurt_cast.set_right()
			
			if not actor.is_on_floor():
				current_state = CatStates.AIR
				return
			
			if Input.is_action_just_pressed("p1_action") and can_scratch == true:
				actor.play_slash_noise()
				claw_hurt_cast.slash()
				
			if Input.is_action_just_pressed("p1_jump") and actor.is_on_floor():
				actor.velocity.y = JUMP_VELOCITY
				current_state = CatStates.AIR
				jump_released = false
				return
				
			if direction:		
				actor.velocity.x = lerp(actor.velocity.x, direction * SPEED, 0.4)
			else:
				actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.4)
				current_state = CatStates.IDLE
			
			actor.move_and_slide()
	
		CatStates.AIR:
			
			if actor.is_on_floor():
				current_state = CatStates.IDLE
				double_jumped = false
				return
			
			if Input.is_action_just_released("p1_jump") and actor.velocity.y < 0:
				jump_released = true	
			
			if can_double_jump and double_jumped == false:
				if Input.is_action_just_pressed("p1_jump"):
					actor.velocity.y = JUMP_VELOCITY
					jump_released = false
					double_jumped = true

			if Input.is_action_just_pressed("p1_action") and can_scratch == true:
				actor.play_slash_noise()
				claw_hurt_cast.slash()
			
			if actor.velocity.y < 0:
				actor.velocity.y += gravity * delta
				animation_player.play("jump_up")
			else:
				actor.velocity.y += gravity * delta * 1.5
				animation_player.play("jump_down")
				jump_released = false

				
			var direction = Input.get_axis("p1_left", "p1_right")
			if direction < 0:
				sprite_2d.flip_h = true
				claw_hurt_cast.set_left()

			elif direction > 0:
				sprite_2d.flip_h = false
				claw_hurt_cast.set_right()
			
			if jump_released:
				actor.velocity.y = lerp(actor.velocity.y, 0.0, 0.1)

			if direction:		
					actor.velocity.x = lerp(actor.velocity.x, direction * SPEED, 0.1)
			else:
					actor.velocity.x = lerp(actor.velocity.x, 0.0, 0.1)
				
			actor.move_and_slide()
			
			var last_collision = actor.get_last_slide_collision()
			
			
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
			
		
		CatStates.RESPAWNING:
		
			actor.velocity.x = 0
			actor.velocity.y += gravity * delta * 1.5
			animation_player.play("jump_down")

			
			if  actor.is_on_floor():
				current_state = CatStates.IDLE
				hit_box_component.set_deferred("monitorable", true)
					
			actor.move_and_slide()
		
		CatStates.VICTORY_RUN:

			print(actor.is_on_floor())
			if actor.is_on_floor():
				actor.velocity.x = -300
				animation_player.play("running")
			else:
				if actor.velocity.y < 0:
					actor.velocity.y += gravity * delta
					animation_player.play("jump_up")
				else:
					actor.velocity.y += gravity * delta * 1.5
					animation_player.play("jump_down")
					jump_released = false
			
			actor.move_and_slide()

func set_state(new_state: int):
	current_state = new_state



func _on_hurt_timer_timeout():

	set_state(CatStates.IDLE)
	hit_box_component.set_deferred("monitorable", true)
	

func respawn(new_position: Vector2):
	
	set_state(CatStates.RESPAWNING)
	hit_box_component.set_deferred("monitorable", false)
	actor.global_position = new_position
	actor.velocity = Vector2.ZERO
	if not hurt_timer.is_stopped():
		hurt_timer.stop()
	animation_player.play("RESET")
	
	
