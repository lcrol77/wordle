extends Panel

@onready var label: Label = $Label
@onready var timer: Timer = $Timer

func show_with_text(text: String ):
	label.text = text
	show()
	timer.start()

func _on_timer_timeout() -> void:
	hide()
