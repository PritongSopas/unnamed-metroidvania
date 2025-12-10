extends Node

signal interaction_started
signal interaction_ended

@onready var fade_layer = get_tree().current_scene.get_node("FadeLayer")
@onready var dialogue_box = get_tree().current_scene.get_node("DialogueBox")

var player: Node = null
var zone: Node = null

var is_busy = false

func register_player(p):
	player = p
	
func start_game(scene_path: String, entrance_id: String):
	var root_scene = preload("res://levels/root_scene.tscn").instantiate()
	
	var start_menu = get_tree().current_scene
	start_menu.queue_free()

	get_tree().root.add_child(root_scene)
	get_tree().current_scene = root_scene
	
	if not player:
		var player_instance
		if GameData.selected_player_character:
			player_instance = GameData.selected_player_character.instantiate()
		else:
			var player_scene = preload("res://characters/player/gato_player.tscn")
			player_instance = player_scene.instantiate()
			
		get_tree().current_scene.call_deferred("add_child", player_instance)
		SceneManager.register_player(player_instance)
		
		change_scene_to(scene_path, entrance_id)

func change_scene_to(scene_path: String, entrance_id: String):
	call_deferred("_change_scene_deferred", scene_path, entrance_id)

func _change_scene_deferred(scene_path: String, entrance_id: String):
	if fade_layer:
		await fade_layer.fade_out(1)
		
	var current_zone = get_tree().current_scene.get_node("CurrentZone")
	
	var new_zone = load(scene_path).instantiate()
	zone = new_zone

	for child in current_zone.get_children():
		child.queue_free()

	current_zone.add_child(new_zone)
	
	player.get_node("FollowCamera").set_camera_limits(new_zone)

	var spawn_point = new_zone.get_entrance(entrance_id)
	if spawn_point and player:
		player.global_position = spawn_point.global_position
		player.velocity = Vector2.ZERO
		
	if fade_layer:
		await fade_layer.fade_in(1)

func show_dialogue(lines: Array) -> void:
	is_busy = true
	emit_signal("interaction_started")
	dialogue_box.show_dialogue(lines)
	emit_signal("interaction_ended")
	is_busy = false
