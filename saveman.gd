extends Node
# Save manager by kobeDevStuff on GitHub
const save_file_name: String = "user://save_game.json" # You can change this to be whatever you want (save_game.txt, game.save etc.), just don't change the 'user://' at the front
const default_dictionary: Dictionary[String,int] = {
	"levels_completed": 0,
	"level01" : 0,
	"level02" : 0,
	"level03" : 0
	}

## Stores data to a save file to be loaded from later
func save_game(data: Dictionary) -> void:
	var save_file: FileAccess = FileAccess.open(save_file_name, FileAccess.WRITE)
	if save_file == null:
		push_error("Failed to open file.")
		return
	var json_string: String = JSON.stringify(data) # Converts dictionary to one long string "{...}"
	save_file.store_line(json_string)
	save_file.close()

## Loads data from a save file
func load_game() -> Dictionary:
	if FileAccess.file_exists(save_file_name): # i.e. The game has been saved before
		var save_file = FileAccess.open(save_file_name, FileAccess.READ)
		var json = JSON.new()
		
		var json_string = save_file.get_line()
		
		if json.parse(json_string) == OK:
			var data = json.get_data()
			save_file.close()
			return data # Successful retrieval
		else:
			push_error("Corrupted data: " + json.get_error_message())

	return default_dictionary

func reset_save() -> void:
	save_game(default_dictionary)
