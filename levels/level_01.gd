extends Node2D
var done: int = 0
func _ready():
	$bobby.dead = true
	# intro sequence animation
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($welcome,"modulate:a",1,1.2)
	tween.parallel().tween_property($welcome,"position:y",100,1.2)
	tween.tween_interval(0.4)
	tween.tween_property($welcome2,"modulate:a",1,1)
	tween.parallel().tween_property($welcome2,"position:y",280,1)
	tween.tween_callback(func():
		$bobby.dead = false # my first lambda function! half life reference
		done = 1)
func _input(_InputEvent):
	if Input.is_action_just_pressed("click"):
			if done == 1: # fade out intro sequence
				var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_property($welcome,"modulate:a",0,1.2)
				tween.parallel().tween_property($welcome2,"modulate:a",0,1.2)
				$Timer2.start()
	if Input.is_action_just_released("click"):
		if $Timer2.is_stopped() and done == 2: # open the finish
			if Input.is_action_just_released("click"):
				done = 3
				var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
				tween.tween_property($welcome,"modulate:a",0,1.2)
				tween.tween_interval(1)
				tween.tween_property($finish,"position:y",528,1)
	# logic to enable timer for ghost
	if Input.is_action_just_pressed("click"):
		if $bobby.dead == true: pass
		else:
			$Timer.start()
	if Input.is_action_just_released("click"):
		$Timer.stop()
func _on_timer_2_timeout() -> void:
	$welcome.text = "drag to fling bobby around"
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	tween.tween_property($welcome,"modulate:a",1,1.2)
	tween.tween_callback(func(): done = 2)
# spawn ghosts
func _on_timer_timeout() -> void:
	var ghost = $bobby.ghost.instantiate()
	ghost.position = $bobby.position
	add_child(ghost)
# finish box signal
func _on_finish_body_entered(body: Node2D) -> void:
	if body == $bobby:
		print("yo")
