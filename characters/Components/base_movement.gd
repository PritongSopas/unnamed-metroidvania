extends Node

@onready var parent = get_parent()
@onready var hurtbox = parent.get_node("Hurtbox")

var acceleration = 10.0
var max_speed = 150.0

var is_dashing = false
var dash_time = 0.2
var dash_timer = 0.0

func _physics_process(delta: float) -> void:
	if SceneManager.freeze: return
	
	apply_gravity(delta)
	
	if is_dashing:
		dash_timer -= delta
		if dash_timer <= 0:
			is_dashing = false
	elif parent.is_knocked_back:
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
	if not parent.is_knocked_back and not is_dashing:
		var target_speed = -max_speed * modifier
		parent.velocity.x = lerp(parent.velocity.x, target_speed, acceleration * delta)

func move_right(delta: float, modifier: float) -> void:
	if not parent.is_knocked_back and not is_dashing:
		var target_speed = max_speed * modifier
		parent.velocity.x = lerp(parent.velocity.x, target_speed, acceleration * delta)

func jump(delta: float, jump_strength: float) -> void:
	if parent.is_on_floor() and not parent.is_knocked_back:
		parent.velocity.y = jump_strength

func stop(delta: float) -> void:
	if not is_dashing:
		parent.velocity.x = lerp(parent.velocity.x, 0.0, acceleration * delta)

func dash_to(speed: float, target: Node2D) -> void:
	if not target:
		return
	
	var dash_direction = (target.global_position - parent.global_position).normalized()
	
	parent.velocity = dash_direction * speed
	
	is_dashing = true
	dash_timer = 0.2
