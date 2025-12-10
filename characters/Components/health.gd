extends Node2D

signal damaged(current_health)
signal healed(current_health)
signal died

@onready var is_dead = get_parent().is_dead

@export var max_health: int = 67
var current_health: int

func _ready() -> void:
	current_health = max_health;
	
func take_damage(amount: int) -> void:
	current_health -= amount
	emit_signal("damaged", current_health)

	if current_health <= 0:
		current_health = 0
		is_dead = true
		emit_signal("died")
		
func heal(amount: int) -> void:
	current_health += amount
	
	if current_health > max_health:
		current_health = max_health
		
	emit_signal("healed", current_health)
