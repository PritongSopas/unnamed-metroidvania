extends Node2D

@export var open_position: Vector2
@export var closed_position: Vector2

var is_open := false

func open_gate():
	if not is_open:
		is_open = true
		global_position = open_position
		$CollisionShape2D.disabled = true   # not solid

func close_gate():
	if is_open:
		is_open = false
		global_position = closed_position
		$CollisionShape2D.disabled = false  # solid again
