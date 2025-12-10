extends Node2D

const whitelist = ["berry_bush"]

func _ready() -> void:
	call_deferred("_spawn_requirements")
	
func _spawn_requirements() -> void:
	var spawns = get_parent().get_node("Requirements").get_children()
	for spawn in spawns:
		if spawn.requirement_scene:
			var scene_name = spawn.requirement_scene.resource_path.get_file().get_basename()
			print(scene_name)
			if scene_name in whitelist:
				pass
			elif FlagData.flags.get(spawn.flag_id, false):
				continue
			
		var requirement = spawn.requirement_scene.instantiate()
		if "id" in requirement:
			requirement.id = spawn.flag_id
				
		add_child(requirement)
		requirement.global_position = spawn.global_position
