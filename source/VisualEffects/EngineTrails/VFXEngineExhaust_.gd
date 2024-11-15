extends Sprite2D
class_name EngineExhaust

var base_scale:= Vector2.ZERO

func _ready():
	base_scale = scale

func set_speed(in_speed:float):
	scale.x = base_scale.x * in_speed
	material.set_shader_parameter("speed", in_speed)
