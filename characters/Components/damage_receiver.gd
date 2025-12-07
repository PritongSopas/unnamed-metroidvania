extends Node2D

@onready var health = get_node("../Health")
@onready var hurtbox = get_node("../Hurtbox")

func _ready() -> void:
	hurtbox.hit.connect(_on_hit)

func _on_hit(amount: int, source: Node = null) -> void:
	health.take_damage(amount)
	
