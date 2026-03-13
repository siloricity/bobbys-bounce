extends VBoxContainer
func _ready():
	var save = saveman.load_game().duplicate()
	if save["level01"] == 1:
		$%but_l2.disabled = false
	if save["level02"] == 1:
		$%but_l3.disabled = false
	if save["level03"] == 1:
		$%but_l4.disabled = false
	if save["level04"] == 1:
		$%but_l5.disabled = false

func _on_but_pressed(num: int) -> void:
	var path = "res://levels/level"
	match num:
		1: change(path+"01.tscn")
		2: change(path+"02.tscn")
		3: change(path+"03.tscn")
		4: change(path+"04.tscn")
		5: change(path+"05.tscn")
func change(level):
	get_tree().change_scene_to_file(level)
func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://title.tscn")
