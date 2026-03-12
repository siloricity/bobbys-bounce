extends Node
func _input(_InputEvent):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://title.tscn")
