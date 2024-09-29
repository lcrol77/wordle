extends Control
class_name GameOver
@onready var label = $Label

signal next()

func set_label(text: String) -> void:
	label.text = text
