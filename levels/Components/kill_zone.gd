extends Area2D

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.has_node("Hurtbox") and body.is_in_group("enemies"):
		body.get_node("Hurtbox").emit_signal("hit", 999, 0, null)
	elif body.is_in_group("player"):
		GameState.load_last_checkpoint()
