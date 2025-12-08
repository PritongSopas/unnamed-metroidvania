extends Node

@onready var parent = get_parent()
@onready var movement = parent.get_node("BaseMovement")
@onready var player = get_tree().get_first_node_in_group("player")

@export var detection_range = 300.0
@export var speed_modifier = 0.3
@export var jump_strength = -200.0
@export var min_idle_interval = 1.0
@export var max_idle_interval = 2.0
@export var move_duration = 1.0 

var idle_timer: float = 0.0
var move_timer: float = 0.0
var direction: int = 0

func _ready() -> void:
	_start_idle()

func _physics_process(delta: float) -> void:
	movement.apply_gravity(delta)

	# Check distance to player
	var distance_to_player = parent.global_position.distance_to(player.global_position)
	if distance_to_player <= detection_range:
		chase_player(delta)
	else:
		random_movement(delta)

	parent.move_and_slide()

func random_movement(delta: float) -> void:
	if move_timer > 0:
		if direction > 0:
			movement.move_right(delta, speed_modifier)
		elif direction < 0:
			movement.move_left(delta, speed_modifier)
		else:
			movement.stop(delta)
		move_timer -= delta
		if move_timer <= 0:
			_start_idle()
	else:
		movement.stop(delta)
		idle_timer -= delta
		if idle_timer <= 0:
			_start_move()

func chase_player(delta: float) -> void:
	if player.global_position.x > parent.global_position.x:
		movement.move_right(delta, speed_modifier)
	elif player.global_position.x < parent.global_position.x:
		movement.move_left(delta, speed_modifier)
	else:
		movement.stop(delta)

	# Optional: attack if very close
	if parent.global_position.distance_to(player.global_position) < 50:
		attack_player()

func attack_player() -> void:
	pass

func _start_idle() -> void:
	direction = 0
	idle_timer = randf_range(min_idle_interval, max_idle_interval)
	move_timer = 0

func _start_move() -> void:
	direction = randi() % 3 - 1
	move_timer = move_duration
