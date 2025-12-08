extends CharacterBody2D

signal attack_pressed

@onready var movement = get_node("BaseMovement")
@onready var attack_controller = get_node("AttackController")

@export var speed = 300.0
@export var jump_strength = -600.0

func _physics_process(delta: float) -> void:
	movement.apply_gravity(delta)
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		movement.move_right(delta, speed)
	elif direction < 0:
		movement.move_left(delta, speed)
	else:
		movement.stop()
		
	if Input.is_action_pressed("jump"):
		movement.jump(jump_strength)

	move_and_slide()
