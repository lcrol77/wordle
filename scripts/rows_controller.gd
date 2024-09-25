extends VBoxContainer
class_name RowsController

func _ready() -> void:
	SignalBus.connect('letter_pressed', on_letter_pressed)

func on_letter_pressed(letter) -> void:
	print(letter)

func _on_keyboard_backspace_pressed() -> void:
	print("Back")

func _on_keyboard_enter_pressed() -> void:
	print("Enter")
