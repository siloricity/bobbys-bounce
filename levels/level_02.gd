extends Node2D
var progress: int = 0
func _ready():
	$bobby.death.connect(its_okay)
	# intro sequence animation
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($welcome,"modulate:a",1,1.2)
	tween.parallel().tween_property($welcome,"position:y",100,1.2)
	progress = 1
func _input(_InputEvent):
	if Input.is_action_just_pressed("click"):
		if progress == 1: # fade out intro sequence
			var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
			tween.tween_property($welcome,"modulate:a",0,1.2)
		if $bobby.linear_velocity != Vector2.ZERO:
			$bobby.dead = true
	if Input.is_action_just_released("click"):
		$Timer.stop()
		if $failsafe.is_stopped():
			$failsafe.start()
func its_okay():
	$welcome.text = "it's okay to fail"
	$welcome.position.y +=100
	$retrybutton.disabled = false
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($welcome,"modulate:a",1,1.2)
	tween.parallel().tween_property($welcome,"position:y",180,1.2)
	tween.parallel().tween_property($retrybutton,"modulate:a",1,1.2)
# spawn ghosts
func _on_timer_timeout() -> void:
	var ghost = $bobby.ghost.instantiate()
	ghost.position = $bobby.position
	add_child(ghost)
# finish box signal
func _on_finish_body_entered(body: Node2D) -> void:
	if body == $bobby:
		$bobby.dead = true
		$retrybutton.disabled = false
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property($complete,"position:y",330,1)
		tween.parallel().tween_property($retrybutton,"modulate:a",1,1.2)
		var dict = saveman.load_game().duplicate()
		if dict["level02"] != 1:
			dict["level02"] = 1
			dict["levels_completed"] += 1
			saveman.save_game(dict)
# next level
func _on_comp_button_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level03.tscn")
# retry button
func _on_retrybutton_pressed() -> void:
	get_tree().reload_current_scene()
