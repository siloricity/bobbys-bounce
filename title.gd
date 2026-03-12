extends Node2D

func _ready():
	var dict = saveman.load_game()
	$BoxContainer/HBoxContainer/LevelCount.text = str(int(dict["levels_completed"]))+" / 20 levels completed"
	$AnimationPlayer.play("bounce_title")
	$AnimationPlayer2.play("wheel_title")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level01.tscn")
func _on_butt_lore_pressed() -> void:
	pass # Replace with function body.
func _on_butt_quit_pressed() -> void:
	get_tree().quit()
func _input(_InputEvent):
	if Input.is_action_pressed("ctrl") and Input.is_action_pressed("shift") and Input.is_action_just_pressed("r"):
		saveman.reset_save()
