extends StaticBody2D
class_name Planet

const CARGO = preload("res://Nodes/cargo.tscn")

var cargo_count := 0
var cargo_count_max := 10
@onready var cargo_container = $CargoContainer

func _physics_process(delta):
	pass

func take_cargo():
	if cargo_count > 0 :
		var taken_cargo = cargo_container.get_child(0)
		taken_cargo.queue_free()
		cargo_count -= 1

func add_cargo():
	if cargo_count < cargo_count_max:
		var new_cargo = CARGO.instantiate()
		cargo_container.add_child(new_cargo)
		cargo_count += 1

func _on_timer_timeout():
	add_cargo()


func _on_pickup_area_body_entered(body):
	body.entered_planet(self)


func _on_pickup_area_body_exited(body):
	body.exited_planet()
