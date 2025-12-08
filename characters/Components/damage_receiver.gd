extends Node2D

@onready var parent = get_parent()
@onready var health = parent.get_node("Health")
@onready var hurtbox = parent.get_node("Hurtbox")
@onready var sprite = parent.get_node("Sprite")

var can_take_damage = true

func _ready() -> void:
	hurtbox.hit.connect(_on_hit)

func _on_hit(amount: int, knockback_strength: int, source: Node = null) -> void:
	if not can_take_damage:
		return
		
	can_take_damage = false
	_start_damage_cooldown()
	
	if source:
		var knock_x = 1 if parent.global_position.x > source.global_position.x else -1
		var knock_y = -0.3
		parent.velocity = Vector2(knock_x * knockback_strength, knock_y * knockback_strength)
		parent.is_knocked_back = true
		parent.knockback_timer = 0.2
		
	flash_red()
	health.take_damage(amount)
	
func flash_red() -> void:
	var original_color = sprite.modulate
	sprite.modulate = Color(1.0, 0.0, 0.0, 1.0)
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = original_color
	
func _start_damage_cooldown():
	await get_tree().create_timer(0.3).timeout
	can_take_damage = true
