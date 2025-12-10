extends Area2D

@export var checkpoint_id: String = "default"

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and checkpoint_id not in GameState.triggered_checkpoints:
		GameState.save_checkpoint(checkpoint_id, self.global_position)
