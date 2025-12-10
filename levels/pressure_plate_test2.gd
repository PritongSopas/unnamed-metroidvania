extends Area2D

@export var output_value: int = 1  # value to send when pressed
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
	# If nothing is on the plate anymore:
	if get_overlapping_bodies().size() == 0:
		is_pressed = false
		value_changed.emit(0)  # send zero / false
