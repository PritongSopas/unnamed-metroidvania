extends Node

@onready var parent = get_parent()
@onready var movement = parent.get_node("BaseMovement")
@onready var attack_controller = parent.get_node("AttackController")

@export var speed_modifier = 1.0
@export var jump_strength = -550.0

func _process(delta: float) -> void:
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		movement.move_right(delta, speed_modifier)
	elif direction < 0:
		movement.move_left(delta, speed_modifier)
	else:
		movement.stop(delta)
		
	if Input.is_action_pressed("jump"):
		movement.jump(delta, jump_strength)
