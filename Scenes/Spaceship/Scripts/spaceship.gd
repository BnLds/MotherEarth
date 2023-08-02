extends RigidBody2D
class_name Spaceship

@export var torque_value := 50.0
@export var boost_value := 100.0

var has_left_planet:= false

func _physics_process(delta):
	if sleeping:
		return
	
	if Input.is_action_pressed("rotate_left"):
		apply_torque(-torque_value)
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(torque_value)
		
	if Input.is_action_pressed("speed_up"):
		has_left_planet = true
		
		var boost_vect = -transform.y * boost_value
		apply_force(boost_vect)

func _on_area_2d_area_entered(area):
	if area is BigPlanet && has_left_planet:
		sleeping = true
	
