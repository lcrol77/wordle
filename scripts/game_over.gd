extends Control
class_name GameOver
@onready var label = $Label

signal next()

func _on_play_again_pressed() -> void:
	next.emit()

func _on_exit_pressed() -> void:
	get_tree().quit()
