extends Button
class_name KeyboardButton

@export var letter: String
@export var state := Enums.State.Empty

const state_to_theme = ["letter_available", "used", "correct_wrong_placement", "correct_right_placement"]

func _ready() -> void:
	name = letter
	theme_type_variation = state_to_theme[state]

func set_state(new_state: Enums.State):
	if new_state == Enums.State.Incorrect:
		disabled = true
	if state != Enums.State.CorrectRightPlace:
		state = new_state
		theme_type_variation = state_to_theme[state]
