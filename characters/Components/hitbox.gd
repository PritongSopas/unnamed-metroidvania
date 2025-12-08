extends Area2D

signal hit(amount: int, knockback: int, source: Node)

@onready var parent = get_parent()
@onready var hitbox = parent.get_node("Hitbox")
@onready var camera = parent.get_node("FollowCamera")

@export var knockback: int = 100
@export var damage: int = 10

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	
func _on_body_entered(body: Node) -> void:
	if body.has_node("Hurtbox"):
		body.get_node("Hurtbox").emit_signal("hit", damage, knockback, parent)
		camera.shake(0.15, 8)
		emit_signal("hit", damage, knockback, parent)
