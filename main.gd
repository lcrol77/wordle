extends Node
@onready var game_container: VBoxContainer = $HBoxContainer/VBoxContainer
@onready var validation_alert: Panel = %ValidationAlert

func _process(delta: float) -> void:
	validation_alert.position.x = game_container.position.x + (game_container.size.x / 2) - (validation_alert.size.x/2)
