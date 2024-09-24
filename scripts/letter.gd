extends Panel

class_name Letter

const state_to_theme_map = [
	"empty",
	"incorrect",
	"correct_wrong_placement",
	"correct_right_placement"
]

var letter_value: String
@onready var label: Label = $Label
@export var state: Enums.State = Enums.State.Empty
@export var letter: String: 
	get: 
		return letter_value
	set(val):
		letter_value = val
		if label != null:
			label.text = val.to_upper()

func set_tile_state(new_state: Enums.State) -> void:
	state = new_state
	theme_type_variation = state_to_theme_map[state]
	
func _ready() -> void:
	theme_type_variation = state_to_theme_map[state]
	label.text = "" if state == Enums.State.Empty else letter
