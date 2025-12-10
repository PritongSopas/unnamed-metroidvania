extends Node2D

@export var level_id: String = ""
@export var default_entrance: String = "default"

func get_entrance(entrance_id: String) -> Marker2D:
	var entrances = get_node("Entrances")
	if not entrances:
		return null

	for child in entrances.get_children():
		if child is Marker2D and child.entrance_id == entrance_id:
			return child

	return entrances.get_node("default")
