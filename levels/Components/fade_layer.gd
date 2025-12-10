extends CanvasLayer

@onready var fade = get_node("Fade")

func fade_in(duration := 0.5) -> void:
	fade.visible = true
	fade.modulate.a = 1.0
	tween_property(fade, "modulate:a", 0.0, duration)

func fade_out(duration := 0.5) -> void:
	fade.visible = true
	fade.modulate.a = 0.0
	tween_property(fade, "modulate:a", 1.0, duration)

func tween_property(node, property, target_value, duration):
	var tween = get_tree().create_tween()
	tween.tween_property(node, property, target_value, duration)
	return tween
