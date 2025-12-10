extends Node2D

func _ready() -> void:
	call_deferred("_spawn_enemies")
	
func _spawn_enemies() -> void:
	var spawns = get_parent().get_node("EnemySpawns").get_children()
	var scene_id = get_parent().level_id
	for spawn in spawns:
		if spawn.enemy_scene:
			var enemy_id = spawn.enemy_id
			if EnemyData.killed_enemies.get(scene_id, []).has(enemy_id):
				continue
			
			var enemy = spawn.enemy_scene.instantiate()
			if "id" in enemy:
				enemy.id = enemy_id
				
			add_child(enemy)
			enemy.global_position = spawn.global_position
