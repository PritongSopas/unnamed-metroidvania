extends Area2D

@onready var animation_player = get_node("AnimationPlayer")

var id: String = ""

func _ready() -> void:
	animation_player.play("float")
	animation_player.animation_finished.connect(_on_animation_finished)
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		FlagData.flags[id] = true
		animation_player.play("collected")
	
func _on_animation_finished() -> void:
	if animation_player.animation == "collected":
		queue_free()
