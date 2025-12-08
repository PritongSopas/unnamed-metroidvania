extends BaseCharacter
class_name BasePlayer

func _ready() -> void:
	add_to_group("player")	
	self.scale = Vector2(4, 4)
