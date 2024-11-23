extends Node2D

const ANGULAR_ACCELERATION := 12.0
const LINEAR_ACCELERATION  := 400.0
const ANGULAR_DAMPING := 4.0
const LINEAR_DAMPING  := 1.0

var angular_velocity := 0.0
var heading := 0.0
var speed := 0.0
var velocity := Vector2.ZERO
var facing := Vector2.RIGHT

var thrust :float = 0.0
var thrust_angular :float = 0.0

var is_interact_pressed :bool = false
#var is_moving_foreward :bool = false
var is_in_orbit :bool = false
var is_lmb_pressed :bool = false

var planet: Planet

@onready var visual := $Visual as Node2D
@onready var wing_1: Sprite2D = $Visual/Wing1
@onready var wing_2: Sprite2D = $Visual/Wing2
@onready var vfx_engine_trail_1: Trail = $VFXEngineTrail1
@onready var vfx_engine_trail_2: Trail = $VFXEngineTrail2
@onready var marker_2d_1: Marker2D = $Visual/Marker2D1
@onready var marker_2d_2: Marker2D = $Visual/Marker2D2

func _ready() -> void:
	vfx_engine_trail_1.setup(marker_2d_1.global_position, marker_2d_1.global_position + facing * 15)
	vfx_engine_trail_2.setup(marker_2d_2.global_position, marker_2d_2.global_position + facing * 15)
	pass

func _physics_process(delta):
	process_input()

	angular_velocity += thrust_angular * ANGULAR_ACCELERATION * delta
	angular_velocity -= angular_velocity * ANGULAR_DAMPING  * delta
	heading += angular_velocity * delta
	
	facing = Vector2.RIGHT.rotated(heading)
	
	velocity += facing * thrust * LINEAR_ACCELERATION * delta
	velocity -= velocity.project(facing.orthogonal()) * LINEAR_DAMPING * delta
	velocity -= velocity * LINEAR_DAMPING * delta
	position += velocity * delta
	speed = velocity.length() + 0.00001
	#print(speed * 0.01)
	
	visual.rotation = heading
	var speed_wing_tweak = clamp(speed * 0.002 * velocity.dot(facing) / speed, -0.3, 1.0)
	wing_1.rotation = -0.479966 - speed_wing_tweak - angular_velocity * 0.1
	wing_2.rotation =  0.479966 + speed_wing_tweak - angular_velocity * 0.1
	vfx_engine_trail_1.position_this_frame1 = marker_2d_1.global_position
	vfx_engine_trail_1.position_this_frame2 = marker_2d_1.global_position + facing * 15
	vfx_engine_trail_2.position_this_frame1 = marker_2d_2.global_position
	vfx_engine_trail_2.position_this_frame2 = marker_2d_2.global_position + facing * 15
	
	#vfx_engine_trail_1.material.set_shader_parameter("speed", speed*0.001)
	#vfx_engine_trail_2.material.set_shader_parameter("speed", speed*0.001)

func entered_planet(in_planet:Planet):
	is_in_orbit = true
	planet = in_planet
	
func exited_planet():
	is_in_orbit = false
	planet = null

func process_input():
	thrust_angular = 0.0
	if Input.is_action_pressed("Right"):
		thrust_angular += 1
	if Input.is_action_pressed("Left"):
		thrust_angular -= 1
	
	thrust = 0.0
	if Input.is_action_pressed("Up"):
		thrust += 1.0
	if Input.is_action_pressed("Down"):
		thrust -= 1.0
	
	is_lmb_pressed = false
	if Input.is_action_pressed("Interact"):
		is_lmb_pressed = true

	if Input.is_action_pressed("Boost"):
		thrust *= 2.0

	#left_mouse_button_pressed = false
	#if Input.is_action_pressed("left_mouse_button"):
		#left_mouse_button_pressed = true
