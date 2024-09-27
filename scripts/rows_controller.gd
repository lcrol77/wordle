extends VBoxContainer
class_name RowsController

@onready var word_pool: WordPool = %WordPool
@onready var keyboard: Keyboard = %Keyboard
@onready var validation_alert: Panel = %ValidationAlert

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
	var is_length_valid = await validate_length()
	if !is_length_valid:
		return
	letter_tiles = rows[active_row_index].get_children()
	letters = letter_tiles.map(func (c): return c.letter)
	var word_to_check = "".join(letters)
	if word_pool.check_word(word_to_check.to_upper()):
		on_word_valid(word_to_guess, letters)
	else:
		validation_alert.show_with_text("Word does not exist")

func validate_length():
	if active_letter_index == 4:
		return true
		
	validation_alert.show_with_text("Not enough letters")
	return false 

func on_word_valid(word: String, letters) -> void:
	var validation_result = validate_word(word, letters)
	for i in letter_tiles.size():
		letter_tiles[i].set_tile_state(validation_result[i])
	keyboard.on_letters_validated(letters, validation_result)
	active_row_index += 1
	active_letter_index = -1
	var has_won = true
	for result in validation_result:
		if result != Enums.State.CorrectRightPlace:
			has_won = false
	if has_won:
		on_win()
	elif active_row_index >= rows.size():
		active_row_index = rows.size()-1
		on_lose()

func on_win():
	print_debug("Win")

func on_lose():
	print_debug("Lose")

func validate_word(word: String, letters) -> Array[Enums.State]:
	var validation_results: Array[Enums.State] = []
	for i in  letters.size():
		var current_letter = letters[i]
		if word.to_upper().contains(current_letter.to_upper()):
			var letter_idx_in_word:Array[int] =get_all_occurances(word, current_letter)
			var is_correct_right_place = false
			for idx in letter_idx_in_word:
				print_debug(idx)
				print_debug(i)
				if idx == i:
					is_correct_right_place = true
					break
			if is_correct_right_place:
				validation_results.append(Enums.State.CorrectRightPlace)
			else:
				validation_results.append(Enums.State.CorrectWrongPlace)
		else:
			validation_results.append(Enums.State.Incorrect)
	return validation_results

func get_all_occurances(word:String, current_letter) -> Array[int]:
	var occurances: Array[int] = []
	var last_index: int = 0
	var is_present = true
	while is_present :
		last_index  = word.findn(current_letter, last_index)
		if last_index == -1:
			is_present = false
			break
		occurances.append(last_index)
	return occurances
