extends Line2D
class_name Trail
#top_level and show_beching_parent will fuck this up at some point !!!

@export var max_points: int = 10
@export var performance_magic_number = 0
var position_this_frame1 := Vector2.ZERO
var position_this_frame2 := Vector2.ZERO
var position_last_frame := Vector2.ZERO
var counter:= 0

func setup(point_1:Vector2, point_2:Vector2):
	position_this_frame1 = point_1
	position_this_frame2 = point_2
	position_last_frame = position_this_frame1
	add_point(position_this_frame1)
	add_point(position_this_frame2)

func _ready():
	counter = randi()%(performance_magic_number + 1)

func _physics_process(_delta: float) -> void:
	var position_difference = (position_this_frame1 - position_this_frame2) * position_last_frame.distance_to(position_this_frame1) * 0.1
	#if counter > 0:
		#counter-= 1
	if position_this_frame1 != points[points.size()-2]:
		for i in points.size()-2:
			points[i] = points[i+1] + position_difference
		if points.size() < max_points:
			points[points.size()-1] = position_this_frame1
			add_point(position_this_frame2)
		else:
			points[points.size()-2] = position_this_frame1
			points[points.size()-1] = position_this_frame2
		#counter = performance_magic_number
	
	position_last_frame = position_this_frame1
	#queue_redraw()
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

#func _draw():
	#for i in points.size():
		#draw_rect(Rect2(points[i]-Vector2.ONE*2.0, Vector2.ONE*4.0), Color.WHITE)
		#
