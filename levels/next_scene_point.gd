extends Area2D

@export var next_scene: String = "res://levels/l_1s_2.tscn"

func _on_body_entered(body):
	print(body)
	if body.is_in_group("player"):
		get_tree().change_scene_to_file(next_scene)
