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
func _on_body_entered(body: Node) -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self,"modulate:a",0, 0.4)
	tween.tween_callback(func(): queue_free())
