extends BaseCharacter
class_name BaseEnemy

var id: String = ""

func _ready() -> void:
	add_to_group("enemies")
	sprite.animation_finished.connect(_on_animation_finished)
