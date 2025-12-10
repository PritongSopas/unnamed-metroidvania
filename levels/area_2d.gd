extends Area2D


@export var output_value: int = 1

var is_pressed: bool = false

signal value_changed(new_value)

func _ready():
	connect("body_entered", _on_body_entered)
	connect("body_exited", _on_body_exited)
	
func _on_body_entered(body):
	if not is_pressed:
		is_pressed = true
		value_changed.emit(output_value)
		
func _on_body_exited(body):
	# Check if plate is fully clear (multiple bodies)
	if get_overlapping_bodies().is_empty():
		is_pressed = false
		value_changed.emit(0)  # 0 means "not pressed"
