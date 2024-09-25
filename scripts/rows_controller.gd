extends VBoxContainer
class_name RowsController

@onready var word_pool: WordPool = %WordPool
@onready var keyboard: Keyboard = %Keyboard
@onready var rows: Array[HBoxContainer] = [
	$Row1, $Row2, $Row3, $Row4, $Row5
]
var word_to_guess := ""

var active_row_index = 0
var active_letter_index = -1
var is_row_filled = false
var letters
var letter_tiles

func _ready() -> void:
	SignalBus.connect('letter_pressed', on_letter_pressed)
	word_to_guess = word_pool.get_random_word()

func on_letter_pressed(letter) -> void:
	if active_letter_index < 4:
		active_letter_index += 1
	if active_letter_index <= 4:
		rows[active_row_index].get_child(active_letter_index).letter = letter
	

func _on_keyboard_backspace_pressed() -> void:
	if active_letter_index >= 0:
		rows[active_row_index].get_child(active_letter_index).letter = ""
		active_letter_index -=1

func _on_keyboard_enter_pressed() -> void:
	print("Enter")
