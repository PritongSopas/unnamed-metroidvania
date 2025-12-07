extends CharacterBody2D

@onready var health = get_node("Health")

func _ready() -> void:
	health.died.connect(_on_death)
	
func _on_death() -> void:
	queue_free()
