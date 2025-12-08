extends Node

@onready var parent = get_parent()
@onready var hurtbox = parent.get_node("Hurtbox")

var acceleration = 10.0
var max_speed = 200.0

func _physics_process(delta: float) -> void:
	apply_gravity(delta)
	if parent.is_knocked_back:
		hurtbox.monitoring = false
		parent.velocity.x = lerp(parent.velocity.x, 0.0, delta * 4.0)
	else:
		hurtbox.monitoring = true

	parent.knockback_timer -= delta
	if parent.knockback_timer <= 0:
		parent.is_knocked_back = false

	parent.move_and_slide()

func apply_gravity(delta: float) -> void:
	parent.velocity += parent.get_gravity() * delta

func move_left(delta: float, modifier: float) -> void:
	if not parent.is_knocked_back:
		parent.velocity.x = lerp(parent.velocity.x, -max_speed, acceleration * modifier * delta)

func move_right(delta: float, modifier: float) -> void:
	if not parent.is_knocked_back:
		parent.velocity.x = lerp(parent.velocity.x, max_speed, acceleration * modifier * delta)

func jump(delta: float, jump_strength: float) -> void:
	if parent.is_on_floor() and not parent.is_knocked_back:
		parent.velocity.y = jump_strength

func stop(delta: float) -> void:
	parent.velocity.x = lerp(parent.velocity.x, 0.0, acceleration * delta)
