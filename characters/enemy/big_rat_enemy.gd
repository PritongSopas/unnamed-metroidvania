extends BaseEnemy

func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)
	self.scale = Vector2(8, 8)
