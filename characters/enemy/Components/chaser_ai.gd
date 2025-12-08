extends Node

@onready var parent = get_parent()
@onready var movement = parent.get_node("BaseMovement")
@onready var attack_controller = parent.get_node("AttackController")
@onready var health = parent.get_node("Health")
@onready var player = get_tree().get_first_node_in_group("player")
@onready var player_health = player.get_node("Health")
@onready var is_hurt = parent.get_node("AnimationController").is_hurt

@export var detection_range = 300.0
@export var speed_modifier = 0.3
@export var jump_strength = -200.0
@export var min_idle_interval = 1.0
@export var max_idle_interval = 2.0
@export var move_duration = 1.0 

var idle_timer: float = 0.0
var move_timer: float = 0.0
var attack_timer: float = 0.0
var direction: int = 0
var is_player_dead = false
var is_dead = false

func _ready() -> void:
	player_health.died.connect(_on_player_death)
	health.died.connect(_on_death)
	_start_idle()
	
func _physics_process(delta: float) -> void:
	if is_dead: return
	if not player or is_player_dead:
		random_movement(delta)
		return
		
	# Check distance to player
	var distance_to_player = parent.global_position.distance_to(player.global_position)
	if distance_to_player <= detection_range:
		chase_player(delta)
	else:
		random_movement(delta)

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
	if attack_timer > 0:
		attack_timer -= delta
		return
		
	if player.global_position.x > parent.global_position.x:
		movement.move_right(delta, speed_modifier)
	elif player.global_position.x < parent.global_position.x:
		movement.move_left(delta, speed_modifier)
	else:
		movement.stop(delta)

	if parent.global_position.distance_to(player.global_position) < 50 and not is_hurt:
		attack_controller.attack({
			"hitboxes": {
				"Hitbox": [2, 3],
			},
		})
		attack_timer = 1.0

func _start_idle() -> void:
	direction = 0
	idle_timer = randf_range(min_idle_interval, max_idle_interval)
	move_timer = 0

func _start_move() -> void:
	direction = randi() % 3 - 1
	move_timer = move_duration
	
func _on_player_death() -> void:
	is_player_dead = true
	
func _on_death() -> void:
	is_dead = true
