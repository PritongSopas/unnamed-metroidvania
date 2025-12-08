extends BaseEnemyStats

func _ready() -> void:
	attack_range = 100
	detection_range = 400
	attack_timer = 4.0
	attack_frames = {
		"hitboxes": {
			"Hitbox": [2, 3, 4]
		}
	}
