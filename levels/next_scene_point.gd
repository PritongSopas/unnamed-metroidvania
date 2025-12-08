extends Area2D

@onready var parent = get_parent()
@onready var respawn_manager = parent.get_node("RespawnManager")
@onready var fade = respawn_manager.get_node("Fade")
@export var next_scene: String = "res://levels/l_1s_2.tscn"

func _ready() -> void:
	self.body_entered.connect(_on_body_entered)
	
func _on_body_entered(body) -> void:
	if body.is_in_group("player"):
		fade.modulate.a = 0
		fade.visible = true
		
		var tween = create_tween()
		tween.tween_property(fade, "modulate:a", 1.0, 1.0)
		tween.tween_callback(Callable(self, "_on_fade_complete"))

func _on_fade_complete() -> void:
	get_tree().change_scene_to_file(next_scene)
