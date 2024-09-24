extends Node
class_name WordPool

var words = ["ABACK"]

func get_random_word()->String:
	return words.pick_random()
