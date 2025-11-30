extends RigidBody2D
@export var sling_multiplier:float
@export var max_sling:int
var released := false
var startpos: Vector2
# rotate the sling
func _process(_delta):
	var mouse = get_global_mouse_position()
	if not Input.is_action_pressed("click"): pass
	else:
		if not Input.is_action_just_pressed("click"): pass
		else:
			startpos = mouse
		$star.show()
		self.look_at(mouse)
		self.rotation_degrees -= 90
		$star.global_position = mouse
	if not Input.is_action_just_released("click"): pass
	else:
		$star.hide()
		self.freeze = false
		self.linear_velocity = sling_multiplier*(self.global_position-mouse)
# bounce or die
func _on_body_entered(body: Node) -> void:
	if body.name != "TileHazards":
		# I've heard it said that random pitch sounds better
		bump_sound(randf_range(0.5,2))
	else:
		EXPLODES()
# collide sound
func bump_sound(pitch):
	$BumpSound.pitch_scale = pitch
	$BumpSound.play()
# death sfx
func EXPLODES():
	self.sleeping = true
	$Sprite2D.modulate.a = 0
	$DeathFX.emitting = true
	$DeathSound.play()
