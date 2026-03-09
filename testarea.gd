extends Node2D

func _process(_delta):
	if Input.is_action_just_pressed("click"):
		if $bobby.dead == true: pass
		else:
			$Timer.start()
	if Input.is_action_just_released("click"):
		$Timer.stop()


func _on_timer_timeout() -> void:
	var ghost = $bobby.ghost.instantiate()
	ghost.position = $bobby.position
	add_child(ghost)
