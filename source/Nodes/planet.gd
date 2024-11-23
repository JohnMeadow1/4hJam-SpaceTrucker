extends StaticBody2D
class_name Planet

const CARGO = preload("res://Nodes/cargo.tscn")

var cargo_count := 0
var cargo_count_max := 10
var tween:Tween
@onready var cargo_container: GridContainer = $CargoContainer
@onready var highlight: Sprite2D = $Highlight


func _physics_process(_delta):
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



func animate():
	if tween:
		tween.kill() # Abort the previous animation.
	tween = create_tween()



func _on_timer_timeout():
	add_cargo()


func _on_pickup_area_body_entered(body):
	body.entered_planet(self)
	animate()
	tween.tween_property(highlight, "modulate", Color(1.0,1.0,1.0,0.1), 0.5).set_trans(Tween.TRANS_SINE)

func _on_pickup_area_body_exited(body):
	body.exited_planet()
	animate()
	tween.tween_property(highlight, "modulate", Color(1.0,1.0,1.0,0.0), 0.5).set_trans(Tween.TRANS_SINE)
