extends Node

@onready var parent = get_parent()
@onready var sprite = parent.get_node("Sprite")

var is_facing_left = false

func _physics_process(delta) -> void:
	var v = parent.velocity
	
	if not parent.is_on_floor() and v.y > 0:
		sprite.play("fall")
	elif not parent.is_on_floor():
		sprite.play("jump")
	elif abs(v.x) > 10:
		sprite.play("run")
	else:
		sprite.play("idle")
		
	if v.x != 0:
		is_facing_left = v.x < 0
		
	sprite.flip_h = is_facing_left
	
	
