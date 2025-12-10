extends CharacterBody2D
class_name BaseCharacter

@onready var health = get_node("Health")
@onready var animation_controller = get_node("AnimationController")
@onready var sprite = get_node("Sprite")

var is_dead = false
var is_knocked_back = false
var knockback_timer: float = 0.2

var is_facing_left = false

func _ready() -> void:
	sprite.animation_finished.connect(_on_animation_finished)

func _on_animation_finished() -> void:
	if sprite.animation == "death":
		if self.is_in_group("enemies"):
			var scene_id = SceneManager.zone.level_id
			if not EnemyData.killed_enemies.has(scene_id):
				EnemyData.killed_enemies[scene_id] = []
			EnemyData.killed_enemies[scene_id].append(self.id)
			queue_free()
		elif self.is_in_group("player"):
			call_deferred("respawn")
			is_dead = false
			
func respawn():
	is_dead = false

	if health:
		health.current_health = health.max_health

	velocity = Vector2.ZERO
	is_knocked_back = false

	GameState.load_last_checkpoint()
	
	sprite.play("idle")
