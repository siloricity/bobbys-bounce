extends Node2D

func _ready():
	$AnimationPlayer.play("bounce_title")
	$AnimationPlayer2.play("wheel_title")
func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level01.tscn")


func _on_butt_lore_pressed() -> void:
	pass # Replace with function body.


func _on_butt_quit_pressed() -> void:
	get_tree().quit()
