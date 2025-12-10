extends Node

@onready var parent = get_parent()
@onready var movement = parent.get_node("BaseMovement")
@onready var attack_controller = parent.get_node("AttackController")
@onready var health = parent.get_node("Health")
@onready var is_dead = parent.is_dead

@export var speed_modifier = 1.0
@export var jump_strength = -300.0
	
func _process(delta: float) -> void:
	if is_dead: return
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		movement.move_right(delta, speed_modifier)
	elif direction < 0:
		movement.move_left(delta, speed_modifier)
	else:
		movement.stop(delta)
	
	if Input.is_action_pressed("jump"):
		movement.jump(delta, jump_strength)
