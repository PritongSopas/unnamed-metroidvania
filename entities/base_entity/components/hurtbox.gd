extends Area2D

signal hit(amount: int, source: Node)

@export var default_damage = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	var damage = body.get_attack() if body.has_method("get_attack") else default_damage
	emit_signal("hit", damage, body)
