extends Area2D

signal activated
signal deactivated

var bodies_on_plate: int = 0

func _on_body_entered(body):
	bodies_on_plate += 1
	if bodies_on_plate == 1:
		emit_signal("activated")

func _on_body_exited(body):
	bodies_on_plate -= 1
	if bodies_on_plate == 0:
		emit_signal("deactivated")
