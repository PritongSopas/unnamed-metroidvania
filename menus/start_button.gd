extends Button

@onready var fade = $Fade  # ColorRect that covers the screen
@export var fade_time: float = 1.0

func _on_StartButton_pressed():
	fade.visible = true
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, fade_time)
	tween.tween_callback(Callable(self, "_start_game"))

func _start_game():
	get_tree().change_scene("res://Scenes/MainGame.tscn")
