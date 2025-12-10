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

func _on_hit(amount, knocback, source) -> void:
	shake(0.15, 8)

func set_camera_limits(zone: Node2D) -> void:
	if zone.has_node("TileMapLayers"):
		var tilemap = zone.get_node("TileMapLayers").get_child(0)
		var used_rect = tilemap.get_used_rect()
		var cell_size = tilemap.tile_set.tile_size
		var world_pos = tilemap.to_global(used_rect.position * cell_size)
		var world_size = used_rect.size * cell_size
		var world_rect = Rect2(world_pos, world_size)

		limit_left = world_rect.position.x
		limit_top = world_rect.position.y
		limit_right = world_rect.position.x + world_rect.size.x
		limit_bottom = world_rect.position.y + world_rect.size.y
