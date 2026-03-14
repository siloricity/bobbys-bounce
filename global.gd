extends Node
func _input(_InputEvent):
	if Input.is_action_just_pressed("esc"):
		get_tree().change_scene_to_file("res://title.tscn")
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()
func _ready():
	# Application ID
	DiscordRPC.app_id = 1482445160360050882
	DiscordRPC.details = "boing"
	DiscordRPC.refresh()
