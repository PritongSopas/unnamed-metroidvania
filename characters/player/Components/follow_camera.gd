extends Camera2D

@onready var hitbox = get_parent().get_node("Hitbox")

var original_position: Vector2
var shake_timer: float = 0.0
var shake_magnitude: float = 5.0

func _ready():
	hitbox.hit.connect(_on_hit)
	original_position = position

func _process(delta: float) -> void:
	if shake_timer > 0:
		position = original_position + Vector2(
			randf_range(-shake_magnitude, shake_magnitude),
			randf_range(-shake_magnitude, shake_magnitude)
		)
		shake_timer -= delta
	else:
		position = original_position

func shake(duration: float = 0.1, magnitude: float = 5.0) -> void:
	shake_timer = duration
	shake_magnitude = magnitude

func _on_hit() -> void:
	shake(0.15, 8)
