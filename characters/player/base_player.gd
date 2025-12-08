extends BaseCharacter
class_name BasePlayer

func _ready() -> void:
	add_to_group("player")	
	sprite.animation_finished.connect(_on_animation_finished)
	self.scale = Vector2(4, 4)
