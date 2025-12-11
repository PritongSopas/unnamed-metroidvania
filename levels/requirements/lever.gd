extends Area2D
class_name Lever

@export var id: String
@export var dialogue: Array = []

@onready var sprite = get_node("Sprite")
@onready var ray = get_node("RayCast2D")
@onready var hint = get_node("Hint")
@onready var player_camera = SceneManager.player.get_node("FollowCamera")

var is_on: bool = false
var player_in_range: bool = false
var floor_offset = 14.0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

	if FlagData.flags.get(id, false):
		is_on = true
		sprite.play("on")
		
	hint.hide()

func _on_body_entered(body):
	if body.is_in_group("player") and not is_on:
		player_in_range = true
		hint.show()
		

func _on_body_exited(body):
	if body.is_in_group("player") and not is_on:
		player_in_range = false
		hint.hide()

func _physics_process(delta):
	ray.force_raycast_update()
	
	if ray.is_colliding():
		global_position.y = ray.get_collision_point().y - floor_offset
		
	if player_in_range and Input.is_action_just_pressed("interact") and not is_on:
		player_in_range = false
		hint.hide()
		FlagData.flags[id] = true
		GameState.emit_signal("requirements_changed")
		is_on = true
		sprite.play("on")
		player_camera.shake()
		if dialogue.size() > 0:
			SceneManager.show_dialogue(dialogue)
		else:
			SceneManager.show_dialogue(["You hear a gate open in distance."])
