extends Node2D

@onready var parent = get_parent()
@onready var attack_controller = parent.get_node("AttackController")
@onready var movement = parent.get_node("BaseMovement")
@onready var player = get_tree().get_first_node_in_group("player")

func _ready() -> void:
	attack_controller.attack_started.connect(_on_attack_start)
	
func _on_attack_start() -> void:
	if player:
		movement.dash_to(500, player)
