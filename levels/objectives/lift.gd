extends Area2D
class_name Lift

@export var id: String                    # Key ID required to activate
@export var speed: float = 50.0          # Elevator movement speed
@export var idle_time: float = 1.0       # Time to wait at top before returning

@onready var start = get_node("../LiftStartMarker")
@onready var end = get_node("../LiftEndMarker")
@onready var hint = $Hint
@onready var player_camera = SceneManager.player.get_node("FollowCamera")
@onready var entity_beneath_detector = get_node("EntityBeneathDetector")

var entity_beneath: bool = false
var target_position: Vector2
var direction: Vector2
var is_active: bool = false
var player_in_range: bool = false
var idle_timer: float = 0.0

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	
	hint.hide()

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		if not is_active:
			hint.show()

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		if not is_active:
			hint.hide()

func _physics_process(delta: float) -> void:
	var entities_beneath = entity_beneath_detector.get_overlapping_areas().size()
	
	if player_in_range and Input.is_action_just_pressed("interact") and not is_active:
		if FlagData.flags.get(id, false):
			is_active = true
			hint.hide()
			SceneManager.show_dialogue(["You insert the key into its panel.", "The lift starts moving."])
			player_camera.shake()
		else:
			SceneManager.show_dialogue(["It's a lift.", "It seems to require a key to get it working."])
	
	if is_active and player_in_range and not SceneManager.freeze and entities_beneath == 0:
		if floor(self.global_position.y) != floor(end.global_position.y):
			self.global_position.y -= speed * delta
			for body in get_overlapping_areas():
				body.global_position.y -= speed * delta
	elif is_active and not player_in_range and not SceneManager.freeze and entities_beneath == 0:
		if floor(self.global_position.y) != floor(start.global_position.y):
			self.global_position.y += speed * delta
			for body in get_overlapping_areas():
				body.global_position.y += speed * delta
