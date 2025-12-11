extends StaticBody2D
class_name PorticullisGate

@export var id: String
@export var keys: bool = false
@export var use_lever: bool = true

@onready var sprite_open_fore = get_node("SpriteOpenFore")
@onready var sprite_open_back = get_node("SpriteOpenBack")
@onready var sprite_closed = get_node("SpriteClosed")
@onready var interaction_range = get_node("InteractionRange")
@onready var collision_shape = get_node("CollisionShape2D")
@onready var hint = get_node("Hint")
@onready var player_camera = SceneManager.player.get_node("FollowCamera")

var is_closed = true
var player_in_range: bool = false

func _ready():
	GameState.requirements_changed.connect(_on_requirements_changed)
	interaction_range.body_entered.connect(_on_body_entered)
	interaction_range.body_exited.connect(_on_body_exited)
	hint.hide()
	
	if FlagData.flags.get(id, false):
		is_closed = false
		collision_shape.disabled = true
		sprite_closed.hide()
		sprite_open_back.show()
		sprite_open_fore.show()
		hint.hide()


func _on_body_entered(body):
	if body.is_in_group("player") and is_closed:
		player_in_range = true
		hint.show()
		

func _on_body_exited(body):
	if body.is_in_group("player") and is_closed:
		player_in_range = false
		hint.hide()

func _process(delta):
	if player_in_range and Input.is_action_just_pressed("interact") and is_closed:
		if use_lever:
			SceneManager.show_dialogue([
				"A porticullis gate...",
				"It seems to be locked.", 
				"There has to be a lever somewhere."
			])
		else:
			if FlagData.flags.get(id, false):
				SceneManager.show_dialogue([
					"You insert the key.",
					"The gate opens."
				])
				player_camera.shake()
				is_closed = false
				collision_shape.disabled = true
				sprite_closed.hide()
				sprite_open_back.show()
				sprite_open_fore.show()
				hint.hide()
			else:
				SceneManager.show_dialogue([
					"A porticullis gate...",
					"There's a keyhole by its beam.", 
					"There has to be a key somewhere."
				])

func _on_requirements_changed():
	if use_lever:
		if FlagData.flags.get(id, false):
			is_closed = false
			collision_shape.disabled = true
			sprite_closed.hide()
			sprite_open_back.show()
			sprite_open_fore.show()
			hint.hide()
