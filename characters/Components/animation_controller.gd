extends Node

@onready var parent = get_parent()
@onready var sprite = parent.get_node("Sprite")
@onready var attack_controller = parent.get_node("AttackController")
@onready var hitbox = parent.get_node("Hitbox")
@onready var hurtbox = parent.get_node("Hurtbox")
@onready var health = parent.get_node("Health")

var is_attacking = false
var is_dead = false
var is_hurt = false

var attack_timer: float = 0.0
var hurt_timer: float = 0.0
var attack_timeout: float = 1.0
var hurt_timeout: float = 1.0

func _ready() -> void:
	health.damaged.connect(_on_hurt)
	sprite.animation_finished.connect(_on_animation_finish)
	attack_controller.attack_started.connect(_on_attack_start)
	attack_controller.attack_finished.connect(_on_attack_finish)
	health.died.connect(_on_death)
	
func _physics_process(delta) -> void:
	var v = parent.velocity
	
	if v.x != 0:
		parent.is_facing_left = v.x < 0
		
	if sprite and not is_hurt:
		sprite.flip_h = parent.is_facing_left
		hitbox.scale.x = -1 if parent.is_facing_left else 1
		
	if is_attacking:
		attack_timer += delta
		if attack_timer > attack_timeout:
			print("Attack stuck! Resetting state.")
			is_attacking = false
			attack_timer = 0.0
	else:
		attack_timer = 0.0 
		
	if is_hurt:
		hurt_timer += delta
		if hurt_timer > hurt_timeout:
			print("Hurt stuck! Resetting state.")
			is_hurt = false
			hurt_timer = 0.0
	else:
		hurt_timer = 0.0 
	
	if not sprite or is_dead or is_hurt or is_attacking: return

	if not parent.is_on_floor() and v.y > 0 and sprite.sprite_frames.has_animation("fall"):
		sprite.play("fall") 
	elif not parent.is_on_floor() and sprite.sprite_frames.has_animation("jump"):
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
	if sprite.sprite_frames.has_animation("hurt"):
		sprite.play("death")
	
func _on_hurt(current_health: int) -> void:
	is_hurt = true
	if sprite.sprite_frames.has_animation("hurt"):
		sprite.play("hurt")
	
func _on_animation_finish() -> void:
	if sprite.animation == "hurt":
		is_hurt = false
	if sprite.animation == "attack":
		is_attacking = false
