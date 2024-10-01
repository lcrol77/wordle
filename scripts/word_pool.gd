extends Node
class_name WordPool

@export var test_word = ""
@onready var file_path  = "res://words.txt"

# words is lowercase
var words: PackedStringArray

func _ready() -> void:
	words = load_file(file_path)
	# godot adds an extra new line to the end of  text files
	# need to remove to prevent cases in which this word returned is ""
	words.remove_at(words.size()-1)
	

func load_file(file_path: String) -> PackedStringArray:
	var file: FileAccess = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	return content.split("\n")

func get_random_word() -> String:
	if test_word.length() == 5:
		return test_word.to_upper()
	return words[randi_range(0, words.size()-1)].to_upper()
	
func check_word(word: String) -> bool:
	return words.has(word.to_lower())
