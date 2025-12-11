extends Control

@onready var animation = get_node("AnimationPlayer")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	animation.play("default")
	
	await get_tree().create_timer(5.0).timeout
	get_tree().quit()
