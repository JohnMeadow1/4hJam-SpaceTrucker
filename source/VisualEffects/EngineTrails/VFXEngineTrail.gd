extends Line2D
class_name Trail
#top_level and show_beching_parent will fuck this up at some point !!!

@export var max_points: int = 10
@export var performance_magic_number = 4
var position_this_frame := Vector2.ZERO
var position_previous_frame := Vector2.ZERO
var counter:= 0


func _ready():
	counter = randi()%(performance_magic_number + 1)
	add_point(position_this_frame)

func _physics_process(delta: float) -> void:
	#position_this_frame =  position_this_frame- position_previous_frame
	if counter > 0:
		counter-= 1
		points[points.size()-1] = position_this_frame
	else:
		if points.size() < max_points + 1:
			add_point(position_this_frame)
			for i in points.size()-1:
				points[i] = points[i + 1]
		else:
			for i in max_points:
				points[i] = points[i + 1]
			points[max_points] = position_this_frame
		counter = performance_magic_number
	#position_previous_frame = position_this_frame


#func _process(delta: float) -> void:
	#global_position = get_global_mouse_position()
	#moved_this_frame = prev_position - global_position
	#if points.size() < max_points+1:
		#add_point(Vector2.ZERO)
		#for i in points.size()-1:
			#points[i] = points[i + 1] + moved_this_frame
	#else:
		#for i in max_points:
			#points[i] = points[i + 1] + moved_this_frame
		#points[max_points] = Vector2.ZERO
	#
	#prev_position = global_position
