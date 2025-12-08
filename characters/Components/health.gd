extends Node2D

signal health_changed(current_health)
signal died

@export var max_health: int = 67
var current_health: int

func _ready() -> void:
	current_health = max_health;
	
func take_damage(amount: int) -> void:
	current_health -= amount
	emit_signal("health_changed", current_health)
	print("Damaged: ", current_health)

	if current_health <= 0:
		current_health = 0
		emit_signal("died")
		
func heal(amount: int) -> void:
	current_health += amount
	
	if current_health > max_health:
		current_health = max_health
		
	emit_signal("health_changed", current_health)
