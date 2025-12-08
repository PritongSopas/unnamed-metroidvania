extends Node

@onready var fade = get_node("Fade")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_health = player.get_node("Health")
@export var fade_time: float = 1.0
@export var death_y = 500

func _ready() -> void:
	player_health.died.connect(_on_player_death)
	
	fade.modulate.a = 1
	fade.visible = true
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 0.0, fade_time)
	tween.tween_callback(Callable(self, "_on_fade_done"))

func _physics_process(delta: float) -> void:
	if player.global_position.y > death_y:
		_on_player_death()

func _on_fade_complete():
	get_tree().reload_current_scene()

func _on_fade_done():
	player.set_physics_process(true)  # re-enable movement after fade-in

func _on_player_death() -> void:
	# Disable player input/movement
	player.set_physics_process(false)
	
	# Make fade visible and fully transparent first
	fade.modulate.a = 0
	fade.visible = true
	
	# Fade to black
	var tween = create_tween()
	tween.tween_property(fade, "modulate:a", 1.0, fade_time)
	tween.tween_callback(Callable(self, "_on_fade_complete"))
