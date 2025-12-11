extends Area2D
class_name Boulder

@export var id: String

@export_file("*.tscn") var target_scene: String
@export var target_entrance: String = "default"

@onready var hint = get_node("Hint")

var player_in_range: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	hint.hide()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		hint.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		hint.hide()

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if FlagData.flags.get(id, false):
			SceneManager.show_dialogue(["You set up the explosives.", "...", "..."])
			SceneManager.end_game()
		else:
			SceneManager.show_dialogue(["A giant boulder blocks your path.", "Perhaps a certain miner has some explosives lying around."])
