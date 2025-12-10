extends CanvasLayer

@onready var fade = get_node("Fade")

func fade_in(duration := 0.5) -> void:
	var tween = create_tween()
	fade.visible = true
	fade.modulate.a = 1.0
	tween.tween_property(fade, "modulate:a", 0.0, duration)
	await tween.finished
	return

func fade_out(duration := 0.5) -> void:
	var tween = create_tween()
	fade.visible = true
	fade.modulate.a = 0.0
	tween.tween_property(fade, "modulate:a", 1.0, duration)
	await tween.finished
	return
