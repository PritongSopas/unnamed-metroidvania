extends Area2D

@onready var dialogue_sprite = get_node("DialogueSprite")

@export var dialogue_lines: Dictionary = {}

var player_in_range: bool = false

func _ready():
	SceneManager.interaction_started.connect(_on_interaction_started)
	SceneManager.interaction_ended.connect(_on_interaction_ended)
	
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and not SceneManager.is_busy:
		var idx = 0
		var matched = false
		for flag_id in dialogue_lines.keys():
			if matched: break
			idx += 1
			if FlagData.flags.get(flag_id, false):
				SceneManager.show_dialogue(dialogue_lines["flag_id"])
				matched = true
				
func _on_interaction_started() -> void:
	pass
	#dialogue_sprite.hide()

func _on_interaction_ended() -> void:
	pass
	#dialogue_sprite.show()
