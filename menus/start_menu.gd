extends Control

@onready var fade = get_node("Fade")  # ColorRect that covers the screen
@onready var button = get_node("Button")
@export var fade_time: float = 1.0

func _ready() -> void:
	fade.modulate.a = 1.0
	fade.visible = true
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, fade_time)
	tween.tween_callback(Callable(self, "_hide_fade"))
	button.pressed.connect(_on_Button_pressed)

func _hide_fade() -> void:
	fade.visible = false
	
func _on_Button_pressed():
	fade.modulate.a = 0.0
	fade.visible = true
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, fade_time)
	tween.tween_callback(Callable(self, "_start_game"))

func _start_game():
	get_tree().change_scene_to_file("res://levels/l_1s_1.tscn")
