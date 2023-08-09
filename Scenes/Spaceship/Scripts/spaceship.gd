extends RigidBody2D
class_name Spaceship

@export var torque_value := 50.0
@export var boost_value := 300.0

@onready var boost_animation = $BoostAnimation
@onready var departure_manager = $"../DepartureManager"

signal boost_on
signal boost_off
signal player_departed
signal player_crashed

var has_left_planet:= false
var is_ready_to_depart := true

func _ready():
	PlayBoostAnimation(false)
	departure_manager.connect("ready_to_depart", on_ready_to_depart)

func _physics_process(delta):
	if not is_ready_to_depart:
		return
		
	if Input.is_action_pressed("rotate_left"):
		apply_torque(-torque_value)
		
	if Input.is_action_pressed("rotate_right"):
		apply_torque(torque_value)
		
	if Input.is_action_pressed("speed_up"):
		if not has_left_planet:
			player_departed.emit()
			has_left_planet = true
		
		var boost_vect = -transform.y * boost_value
		apply_force(boost_vect)
		PlayBoostAnimation(true)
		boost_on.emit()
	else:
		PlayBoostAnimation(false)
		boost_off.emit()

func _on_area_2d_area_entered(area):
	if area is PlanetManager && has_left_planet:
		sleeping = true
		is_ready_to_depart = false
		PlayBoostAnimation(false)
		emit_signal("player_crashed", area)
		has_left_planet = false

func PlayBoostAnimation(should_play):
	if should_play:
		boost_animation.show()
		boost_animation.play()
	else:
		boost_animation.hide()
		
func on_ready_to_depart():
	is_ready_to_depart = true
	
