extends Area2D
class_name ClimbableLadder

@export var id: String

@export_file("*.tscn") var target_scene: String
@export var target_entrance: String = "default"

@onready var destination = get_node("Destination")
@onready var hint = get_node("Hint")
@onready var hint2 = get_node("Hint2")

var player_in_range: bool = false

func _ready():
	GameState.requirements_changed.connect(_on_requirements_changed)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	hint.hide()
	hint2.hide()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		hint.show()
		hint2.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		hint.hide()
		hint2.hide()

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		SceneManager.change_scene_to(target_scene, target_entrance)

func _on_requirements_changed():
	if FlagData.flags.get(id, false):
		self.global_position.y = destination.global_position.y
		hint.hide()
		hint2.hide()
