extends CharacterBody2D
class_name BaseCharacter

@onready var health = get_node("Health")
@onready var animation_controller = get_node("AnimationController")

var is_knocked_back = false
var knockback_timer: float = 0.2

var is_facing_left = false

func _ready() -> void:
	health.died.connect(_on_death)

func _on_death() -> void:
	queue_free()
