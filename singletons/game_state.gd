extends Node

signal requirements_changed

var checkpoint_id: String = ""
var checkpoint_position: Vector2

var triggered_checkpoints: Array = []

var killed_enemies_snapshot: Dictionary = {}
var flags_snapshot: Dictionary = {}

var selected_character: PackedScene = null

func _ready() -> void:
	requirements_changed.connect(_on_requirements_changed)

func save_checkpoint(id: String, pos: Vector2) -> void:
	checkpoint_id = id
	checkpoint_position = pos

	killed_enemies_snapshot = {}
	for scene_id in EnemyData.killed_enemies.keys():
		killed_enemies_snapshot[scene_id] = EnemyData.killed_enemies[scene_id].duplicate()
		
	triggered_checkpoints.append(id)

func load_last_checkpoint() -> void:
	var player = SceneManager.player
	if not player:
		return

	var fade_layer = get_tree().current_scene.get_node("FadeLayer")
	if fade_layer:
		await fade_layer.fade_out(0.5)

	EnemyData.killed_enemies.clear()
	for scene_id in killed_enemies_snapshot.keys():
		EnemyData.killed_enemies[scene_id] = killed_enemies_snapshot[scene_id].duplicate()

	if checkpoint_position:
		player.global_position = checkpoint_position
	else:
		player.global_position = SceneManager.zone.get_entrance("default").global_position

	var health = player.get_node("Health")
	if health:
		health.current_health = health.max_health

	if fade_layer:
		await fade_layer.fade_in(1)

func _on_requirements_changed() -> void:
	print(FlagData.flags)
