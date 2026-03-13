extends RigidBody2D
@export var sling_multiplier:float
@export var max_sling:int
@export var ghost: PackedScene
var released := false
var dead := false
#var hits: Array = []
signal death
# rotate the sling
func _process(_delta):
	var mouse = get_global_mouse_position()
	var vel: Vector2 = sling_multiplier*(self.global_position-mouse)
	$Line2D.rotation = -self.rotation
	$Line2D.points[1] = $LineGuidance.position
	#holding
	if Input.is_action_pressed("click"):
		if dead == true: pass
		else:
			$star.show()
			$Line2D.show()
			$LineGuidance.position=(mouse-self.global_position).limit_length(max_sling/2)
			self.look_at(mouse)
			self.rotation_degrees -= 90
			self.linear_velocity = Vector2.ZERO
			$star.global_position = mouse
	#release
	if Input.is_action_just_released("click"):
		if dead == true: pass
		else:
			$star.hide()
			var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
			tween.tween_property($LineGuidance,"position",Vector2.ZERO,0.1)
			self.freeze = false
			self.gravity_scale = 0
			self.linear_velocity = vel.limit_length(max_sling)
			self.gravity_scale = 1
# bounce or die
func _on_body_entered(body: Node) -> void:
	match body.name:
		"TileBlocks":
			bump_sound(randf_range(0.5,2))
			#hits.push_back(Vector2i(self.position)/17)
			#if hits.size() > 2:
				#if hits[-1] == hits[-3]:
					#self.apply_central_force(Vector2(6000,1))
		"TileHazards":
			EXPLODES()
			#hits.clear()

# Physics anti-softlock by sunshinecoco12 on Discord
func _physics_process(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(linear_velocity * delta, true)
	var ball_radius: float = 15.0
	var friction: float = 0.3
	if collision_info:
		angular_velocity = -linear_velocity.dot(collision_info.get_normal().orthogonal()) / ball_radius * friction

# collide sound
func bump_sound(pitch):
	$BumpSound.pitch_scale = pitch
	$BumpSound.play()
# death sfx
func EXPLODES():
	self.sleeping = true
	dead = true
	death.emit()
	$Sprite2D.modulate.a = 0
	$DeathFX.emitting = true
	$DeathSound.play()
