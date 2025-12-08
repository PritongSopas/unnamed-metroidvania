extends Node

signal attack_started
signal attack_finished

@onready var parent = get_parent()
@onready var hitbox = parent.get_node("Hitbox")
@onready var sprite = parent.get_node("Sprite")
@onready var health = parent.get_node("Health")

var is_attacking = false
var hitbox_frames = {}

func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)
	health.damaged.connect(_on_damaged)
	for shape in hitbox.get_children():
		shape.disabled = true
		
func attack(frame_map: Dictionary) -> void:
	if is_attacking or not frame_map.has("hitboxes"):
		return
		
	hitbox_frames = frame_map["hitboxes"]
	is_attacking = true
	hitbox.monitoring = true
	emit_signal("attack_started")

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
		emit_signal("attack_finished")

func _on_damaged(health) -> void:
	if not is_attacking: return
	
	end_attack()
	emit_signal("attack_finished")
	
