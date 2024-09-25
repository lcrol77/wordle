extends VBoxContainer
class_name Keyboard

signal backspace_pressed
signal enter_pressed

func _on_enter_pressed() -> void:
	enter_pressed.emit()

func _on_backspace_pressed() -> void:
	backspace_pressed.emit()
