extends CanvasLayer

@onready var textbox_container = get_node("TextboxContainer")
@onready var start_symbol = textbox_container.get_node("MarginContainer/HBoxContainer/Start")
@onready var label = textbox_container.get_node("MarginContainer/HBoxContainer/Label")
@onready var end_symbol = textbox_container.get_node("MarginContainer/HBoxContainer/End")

var typing_speed = 0.05
var skip_typing = false
var is_showing = false

func _ready() -> void:
	hide_textbox()

func _process(delta: float) -> void:
	if is_showing and Input.is_action_just_pressed("skip_text"):
		skip_typing = true

func show_textbox() -> void:
	start_symbol.text = "*"
	textbox_container.show()
	textbox_container.modulate.a = 0.0

	var tween = create_tween()
	tween.tween_property(textbox_container, "modulate:a", 1.0, 0.3)

func hide_textbox() -> void:
	label.text = ""
	start_symbol.text = ""
	end_symbol.text = ""
	textbox_container.hide()
	skip_typing = false
	is_showing = false

func type_line(line: String) -> void:
	label.text = ""
	end_symbol.text = ""
	skip_typing = false
	is_showing = true

	for char in line:
		if skip_typing:
			label.text = line
			break
		label.text += char
		await get_tree().process_frame
		await get_tree().create_timer(typing_speed).timeout

	end_symbol.text = "v"

	await get_tree().process_frame

	while true:
		if Input.is_action_just_pressed("skip_text"):
			break
		await get_tree().process_frame

	skip_typing = false
	is_showing = false

func show_dialogue(lines: Array) -> void:
	show_textbox()
	for line in lines:
		await type_line(line)
	hide_textbox()
