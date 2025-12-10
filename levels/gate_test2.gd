extends StaticBody2D

var is_open: bool = false

func _on_plate_value_changed(value):
	if value > 0:
		open_gate()
	else:
		close_gate()
		
func open_gate():
	if is_open:
		return
	is_open = true
	$CollisionShape2D.disabled = true
	$Sprite2D.visible = false

func close_gate():
	if not is_open:
		return
	is_open = false
	$CollisionShape2D.disabled = false
	$Sprite2D.visible = true
