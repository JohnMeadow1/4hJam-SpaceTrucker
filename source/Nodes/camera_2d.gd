extends Camera2D

var visible_region_size := Vector2.ZERO
var visible_region_half_size := Vector2.ZERO

func _ready():
	get_viewport().size_changed.connect(on_viewport_size_changed)

func on_viewport_size_changed():
	%DustParticles.process_material.emission_shape_scale = Vector3(get_viewport().size.x,get_viewport().size.y, 0.0)
