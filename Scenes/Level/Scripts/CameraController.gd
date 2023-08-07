extends Camera2D

@onready var spaceship = $".."
@onready var zoom_timer = $ZoomTimer

var zoom_out := false
var zoom_in := false
var elapsed_time : float = 0
var zoom_duration : float = 3
var current_zoom
var is_boosting := false

func _ready():
	spaceship.connect("boost_on", _on_start_boosting)
	spaceship.connect("boost_off", _on_stop_boosting)

func _process(delta):
	if zoom_out:
		if elapsed_time < zoom_duration:
			zoom = lerp(current_zoom, Vector2(0.3, 0.3), elapsed_time / zoom_duration)
		else:
			zoom_out = false
			zoom_timer.stop()
			
	if zoom_in:
		if elapsed_time < zoom_duration:
			zoom = lerp(current_zoom, Vector2.ONE, elapsed_time / zoom_duration)
		else: 
			zoom_timer.stop()
			zoom_in = false

func _on_start_boosting():
	if is_boosting:
		return
	
	is_boosting = true
	current_zoom = zoom
	elapsed_time = 0
	zoom_out = true
	zoom_in = false
	zoom_timer.start()
	
func _on_stop_boosting():
	if not is_boosting:
		return
		
	is_boosting = false
	current_zoom = zoom
	elapsed_time = 0
	zoom_in = true
	zoom_out = false
	zoom_timer.start()

func _on_zoom_timer_timeout():
	elapsed_time += zoom_timer.wait_time
