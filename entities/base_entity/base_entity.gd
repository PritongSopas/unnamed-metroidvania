extends Node2D

@onready var health = get_node("Health")
@onready var damage_receiver = get_node("DamageReceiver")

func _ready() -> void:
	health.died.connect(_on_death)

func _on_death() -> void:
	queue_free()
