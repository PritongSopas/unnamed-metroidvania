extends Node

@onready var parent = get_parent()
@onready var sprite = parent.get_node("Sprite")
@onready var attack_controller = parent.get_node("AttackController")
@onready var hitbox = parent.get_node("Hitbox")
@onready var health = parent.get_node("Health")

var is_attacking = false
var is_dead = false

func _ready() -> void:
	attack_controller.attack_started.connect(_on_attack_start)
	attack_controller.attack_finished.connect(_on_attack_finish)
	health.died.connect(_on_death)
	
func _physics_process(delta) -> void:
	if not sprite or is_dead: return
	
	var v = parent.velocity
	
	if v.x != 0:
		parent.is_facing_left = v.x < 0
		
	if sprite:
		sprite.flip_h = parent.is_facing_left
		hitbox.scale.x = -1 if parent.is_facing_left else 1
	
	if is_attacking:
		return
	
	if not parent.is_on_floor() and v.y > 0:
		sprite.play("fall") 
	elif not parent.is_on_floor():
		sprite.play("jump")
	elif abs(v.x) > 10:
		sprite.play("run")
	else:
		sprite.play("idle")

func _on_attack_start() -> void:
	is_attacking = true
	sprite.play("attack")
	
func _on_attack_finish() -> void:
	is_attacking = false

func _on_death() -> void:
	is_dead = true
	sprite.play("death")
