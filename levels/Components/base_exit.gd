extends Area2D

@export_file("*.tscn") var target_scene: String
@export var target_entrance: String = "default"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		SceneManager.change_scene_to(target_scene, target_entrance)
