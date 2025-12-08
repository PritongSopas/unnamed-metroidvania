extends "res://characters/player/base_player.gd"

@onready var attack_controller = get_node("AttackController")

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		attack_controller.attack({
			"hitboxes": {
				"Hitbox": [2, 3],
			},
		})
	
