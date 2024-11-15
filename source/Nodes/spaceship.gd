extends Node2D

const ANGULAR_ACCELERATION := 12.0
const LINEAR_ACCELERATION  := 400.0
const ANGULAR_DAMPING := 4.0
const LINEAR_DAMPING  := 1.0

var angular_velocity := 0.0
var orientation := 0.0
var velocity := Vector2()
var heading := Vector2.RIGHT

var thrust :float = 0.0
var thrust_angular :float = 0.0
var interact_pressed := false
var left_mouse_button_pressed :bool = false

var interact_object

@onready var visual := $Visual as Node2D


func _physics_process(delta):
	process_input()

	angular_velocity += thrust_angular * ANGULAR_ACCELERATION * delta
	angular_velocity -= angular_velocity * ANGULAR_DAMPING * delta
	orientation += angular_velocity * delta
	
	heading = Vector2.RIGHT.rotated(orientation)
	
	velocity += heading * thrust * LINEAR_ACCELERATION * delta
	velocity -= velocity * LINEAR_DAMPING * delta
	position += velocity * delta
	
	visual.rotation = orientation


func entered_planet(in_planet:Planet):
	pass
	
func exited_planet():
	pass


func process_input():
	thrust_angular = 0.0
	if Input.is_action_pressed("Right"):
		thrust_angular += 1.0
	if Input.is_action_pressed("Left"):
		thrust_angular -= 1.0
		
	thrust = 0.0
	if Input.is_action_pressed("Up"):
		thrust += 1.0
	if Input.is_action_pressed("Down"):
		thrust -= 1.0
	
	#interact_pressed = false
	#if Input.is_action_pressed("Down"):
		#interact_pressed = true

	#if Input.is_action_pressed("BOOST"):
		#thrust *= 4.0
		#
	#left_mouse_button_pressed = false
	#if Input.is_action_pressed("left_mouse_button"):
		#left_mouse_button_pressed = true
