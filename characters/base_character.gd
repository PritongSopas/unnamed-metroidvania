extends CharacterBody2D
class_name BaseCharacter

signal attack_started
signal attack_finished

@onready var health = get_node("Health")
@onready var animation_controller = get_node("AnimationController")

func _ready() -> void:
	health.died.connect(_on_death)

func _on_death() -> void:
	queue_free()
