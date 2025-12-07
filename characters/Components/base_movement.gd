extends Node

@onready var parent = get_parent()

func apply_gravity(delta: float) -> void:
	parent.velocity += parent.get_gravity() * delta

func move_left(delta: float, speed: float) -> void:
	parent.velocity.x = -speed

func move_right(delta: float, speed: float) -> void:
	parent.velocity.x = speed

func jump(jump_strength: float) -> void:
	if parent.is_on_floor():
		parent.velocity.y = jump_strength

func stop() -> void:
	parent.velocity.x = 0
