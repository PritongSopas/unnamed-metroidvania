extends Control

@onready var button = get_node("Button")

@export_file("*.tscn") var first_level: String

func _ready() -> void:
	button.pressed.connect(_on_Button_pressed)

func _on_Button_pressed():
	SceneManager.start_game("res://levels/level_1/level_1_zone_1.tscn", "default")
