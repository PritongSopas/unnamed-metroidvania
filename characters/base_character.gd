extends CharacterBody2D
class_name BaseCharacter

@onready var health = get_node("Health")
@onready var animation_controller = get_node("AnimationController")
@onready var sprite = get_node("Sprite")

var is_knocked_back = false
var knockback_timer: float = 0.2

var is_facing_left = false

func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)
	self.scale = Vector2(4, 4)

func _on_animation_finished() -> void:
	if sprite.animation == "death":
		queue_free()
