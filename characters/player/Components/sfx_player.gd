extends AudioStreamPlayer2D

@onready var parent = get_parent()
@onready var health = parent.get_node("Health")
@onready var attack_controller = parent.get_node("AttackController")

var jump_sfx = [
	preload("res://assets/sfx/jump1.wav"),
	preload("res://assets/sfx/jump2.wav"),
	preload("res://assets/sfx/jump3.wav")
]

var hit_sfx = [
	preload("res://assets/sfx/hit1.wav"),
	preload("res://assets/sfx/hit2.wav"),
	preload("res://assets/sfx/hit3.wav")
]

var hurt_sfx = [
	preload("res://assets/sfx/hurt1.wav"),
	preload("res://assets/sfx/hurt2.wav"),
	preload("res://assets/sfx/hurt3.wav")
]

var death_sfx = [
	preload("res://assets/sfx/death1.wav"),
	preload("res://assets/sfx/death2.wav"),
	preload("res://assets/sfx/death3.wav")
]

func _ready() -> void:
	health.damaged.connect(_on_damaged)
	health.died.connect(_on_death)
	attack_controller.attack_started.connect(_on_attack_started)
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("jump") and parent.is_on_floor():
		var random_index = randi() % jump_sfx.size()
		self.stream = jump_sfx[random_index]
		play()

func _on_damaged() -> void:
	var random_index = randi() % hurt_sfx.size()
	self.stream = hurt_sfx[random_index]
	play()

func _on_attack_started() -> void:
	var random_index = randi() % hit_sfx.size()
	self.stream = hit_sfx[random_index]
	play()


func _on_death() -> void:
	var random_index = randi() % death_sfx.size()
	self.stream = death_sfx[random_index]
	play()

	
