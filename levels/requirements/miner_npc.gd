extends Area2D
class_name MinerNPC

@export var id: String

@onready var sprite = get_node("Sprite")
@onready var ray = get_node("RayCast2D")
@onready var hint = get_node("Hint")

var player_in_range: bool = false
var floor_offset := 8.0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	if FlagData.flags.get(id, false):
		sprite.play("harvested")
		
	hint.hide()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		hint.show()

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		hint.hide()

func _physics_process(delta):
	ray.force_raycast_update()
	
	if ray.is_colliding():
		global_position.y = ray.get_collision_point().y - floor_offset
		
	if player_in_range and Input.is_action_just_pressed("interact"):
		if FlagData.flags.get("Level2Zone2", false):
			if FlagData.flags.get("l2z2_explosives", false):
				SceneManager.show_dialogue(["The miner is busy munching on berries.", "You already have the explosives, you should probably go and use them."])
			elif FlagData.flags.get("l2z1_miner", false):
				SceneManager.show_dialogue([
					"You ask the miner for explosives.",
					"\"...\"",
				 	"\"I see, explosives, huh?\"",
				 	"\"Yeah, I do have some at hand, but I'm kinda hungry, y'know?\"",
					"\"Here's the deal, bring me atleast two berries, and I'll give you some explosives.\"",
					"There must be some berry bushes in this area."
					])
			elif FlagData.flags.get("l2z1_berry1", false) and FlagData.flags.get("l2z1_berry2", false):
				SceneManager.show_dialogue(["\"As promised...\"", "The miner hands you some explosives in exchange for berries."])
				FlagData.flags["l2z2_explosives"] = true
				GameState.emit_signal("requirements_changed")
			elif FlagData.flags.get("l2z1_berry1", false):
				SceneManager.show_dialogue(["Nah, that won't suffice.", "Bring me atleast two berries."])
			elif FlagData.flags.get("l2z1_berry2", false):
				SceneManager.show_dialogue(["Nah, that won't suffice.", "Bring me atleast two berries."])
			else:
				SceneManager.show_dialogue([
					"\"Bring me atleast two berries, and I'll give you some explosives.\"",
					"There must be some berry bushes in this area."
					])
		else:
			SceneManager.show_dialogue(["\"Need something from me?\""])

		hint.hide()
		GameState.emit_signal("requirements_changed")
