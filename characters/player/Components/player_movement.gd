extends Node

@onready var parent = get_parent()
@onready var movement = parent.get_node("BaseMovement")
@onready var attack_controller = parent.get_node("AttackController")
@onready var health = parent.get_node("Health")

@export var speed_modifier = 1.0
@export var jump_strength = -550.0

var is_dead = false

func _ready() -> void:
	health.died.connect(_on_death)
	
func _process(delta: float) -> void:
	if is_dead: return
	var direction := Input.get_axis("move_left", "move_right")
	if direction > 0:
		movement.move_right(delta, speed_modifier)
	elif direction < 0:
		movement.move_left(delta, speed_modifier)
	else:
		movement.stop(delta)
	
	if Input.is_action_pressed("jump"):
		movement.jump(delta, jump_strength)
	
func _on_death() -> void:
	is_dead = true
