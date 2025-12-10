extends Area2D
class_name BerryBush

@export var id: String

@onready var sprite = get_node("Sprite")

var has_berries: bool = true
var player_in_range: bool = false

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	if FlagData.flags.get(id, false):
		has_berries = false
		sprite.play("harvested")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and has_berries:
		FlagData.flags[id] = true
		GameState.emit_signal("requirements_changed")
		has_berries = false
		sprite.play("harvested")
