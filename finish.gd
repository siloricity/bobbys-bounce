extends Area2D
@onready var noise: FastNoiseLite = preload("res://assets/noise.tres")
func _ready():
	$Polygon2D.polygon = $CollisionPolygon2D.polygon

func sparkle() -> void:
	noise.set_seed(randi())
