extends Node

@onready var parent = get_parent()
@onready var movement = parent.get_node("BaseMovement")

@export var speed = 100.0
@export var jump_strength = -200.0
@export var min_idle_interval = 1.0
@export var max_idle_interval = 2.0
@export var move_duration = 1.0 

var idle_timer: float = 0.0
var move_timer: float = 0.0
var direction: int = 0

func _ready() -> void:
	randomize()
	_start_idle()

func _physics_process(delta: float) -> void:
	movement.apply_gravity(delta)

	if move_timer > 0:
		if direction > 0:
			movement.move_right(delta, speed)
		elif direction < 0:
			movement.move_left(delta, speed)
		else:
			movement.stop()
		move_timer -= delta
		if move_timer <= 0:
			_start_idle()
	else:
		movement.stop()
		idle_timer -= delta
		if idle_timer <= 0:
			_start_move()

	parent.move_and_slide()

func _start_idle() -> void:
	direction = 0
	idle_timer = randf_range(min_idle_interval, max_idle_interval)
	move_timer = 0

func _start_move() -> void:
	direction = randi() % 3 - 1
	move_timer = move_duration
