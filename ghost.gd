extends RigidBody2D
@export var sling_multiplier:float
@export var max_sling:int
var vel: Vector2

func _ready():
	var mouse = get_global_mouse_position()
	self.look_at(mouse)
	self.rotation_degrees -= 90
	vel = sling_multiplier*(self.global_position-mouse)
	self.linear_velocity = vel.limit_length(max_sling)
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0, 1.2)
	tween.tween_callback(func(): queue_free())
# disable self after hitting wall
func _on_body_entered(_body: Node) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0, 0.4)
	tween.tween_callback(func(): queue_free())
# Physics anti-softlock by sunshinecoco12 on Discord
func _physics_process(delta: float) -> void:
	var collision_info: KinematicCollision2D = move_and_collide(linear_velocity * delta, true)
	var ball_radius: float = 15.0
	var friction: float = 0.3
	if collision_info:
		if collision_info.get_collider().has_method("method"):
			self.physics_material_override.bounce = 0
		else:
			self.physics_material_override.bounce = 0.99
		angular_velocity = -linear_velocity.dot(collision_info.get_normal().orthogonal()) / ball_radius * friction
