extends Node

@onready var parent = get_parent()
@onready var hitbox = parent.get_node("Hitbox")
@onready var sprite = parent.get_node("Sprite")

var is_attacking = false
var hitbox_frames = {}

const attacks = {
	"gato_bite": {
		"damage": 10,
		"hitboxes": {
			"Hitbox": [4, 5, 6],
		},
	},
}

func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)
	for shape in hitbox.get_children():
		shape.disabled = true
		
func attack(attack_name: String) -> void:
	if is_attacking:
		return
		
	if not attacks.has(attack_name):
		push_warning("Unknown attack: %s" % attack_name)
		return
		
	hitbox_frames = attacks[attack_name].hitboxes
	is_attacking = true
	hitbox.monitoring = true
	parent.emit_signal("attack_started")

func _physics_process(delta):
	if is_attacking:
		for shape in hitbox.get_children():
			if shape is CollisionShape2D:
				var frames = hitbox_frames.get(shape.name, [])
				shape.disabled = not (sprite.frame in frames)
				
func end_attack() -> void:
	is_attacking = false
	hitbox.monitoring = false
	for shape in hitbox.get_children():
		shape.disabled = true

func _on_animation_finished() -> void:
	if is_attacking and sprite.animation == "attack":
		end_attack()
		parent.emit_signal("attack_finished")
