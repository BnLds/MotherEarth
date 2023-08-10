extends Sprite2D
class_name Arrow_UI

@onready var spaceship = $".."
@onready var arrow_update_timer = $ArrowUpdateTimer
@onready var lerp_timer = $LerpTimer

var init_done := false
var target_position := Vector2.ZERO
var lerp_duration := .2
var elapsed_time := 0.0
var target_rotation : float = 0
var start_rotation : float = 0

func _process(delta):
	if not init_done:
		if(target_position == Vector2.ZERO):
			target_position = spaceship.get_target_position() 
			arrow_update_timer.start()
			lerp_timer.start()
		else:
			init_done = true

func _on_arrow_update_timer_timeout():
	target_rotation = get_angle_to(target_position)
	elapsed_time = 0
	start_rotation = rotation

func _on_lerp_timer_timeout():
	look_at(target_position)
#	elapsed_time += lerp_timer.wait_time
#	if elapsed_time < lerp_duration:
#		rotation = lerp_angle(start_rotation, target_rotation, elapsed_time / lerp_duration)
