extends StaticBody2D

var current_value: int = 0

func _ready():
	var plate = get_node("../PressurePlate")
	plate.value_changed.connect(_on_plate_value_changed)

func _on_plate_value_changed(value):
	current_value = value
	if current_value > 0:
		open_gate()
	else:
		close_gate()

func open_gate():
	print("Gate opened")
	# animation / move node / enable collider

func close_gate():
	print("Gate closed")
	# animation / move node / disable collider
