extends CharacterBody2D


@export var start_left: bool = false
@onready var cpu_behavior = $CPUBehavior

const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	
	if start_left:
		cpu_behavior.flip_char()

func _physics_process(delta):
	pass


func take_damage():
	pass

func die():
	queue_free()


