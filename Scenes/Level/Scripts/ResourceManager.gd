extends Node

@onready var h2o_bar_fill = $"../UILayer/Resource_UI/H2O_UI/H2OBarFill"
@onready var h2o_bar_background = $"../UILayer/Resource_UI/H2O_UI/H2OBarBackground"
@onready var o2_bar_fill = $"../UILayer/Resource_UI/O2_UI/O2BarFill"
@onready var o2_bar_background = $"../UILayer/Resource_UI/O2_UI/O2BarBackground"
@onready var food_bar_fill = $"../UILayer/Resource_UI/Food_UI2/FoodBarFill"
@onready var food_bar_background = $"../UILayer/Resource_UI/Food_UI2/FoodBarBackground"
@onready var fuel_bar_fill = $"../UILayer/Resource_UI/Fuel_UI/FuelBarFill"
@onready var fuel_bar_background = $"../UILayer/Resource_UI/Fuel_UI/FuelBarBackground"
@onready var spaceship = $"../Spaceship"

var h2o_percent_ini = 100
var o2_percent_ini = 100
var food_percent_ini = 100
var fuel_percent_ini = 100

var h2o_percent
var o2_percent
var food_percent
var fuel_percent

var is_boosting:= false
var player_departed := false

func _ready():
	init_resources_ui()
	spaceship.connect("boost_on", _on_start_boosting)
	spaceship.connect("boost_off", _on_stop_boosting)
	spaceship.connect("player_departed", _on_player_departed)
	spaceship.connect("player_crashed", on_crash)

func _on_resource_timer_timeout():
	if not player_departed:
		return
		
	h2o_percent -= 1
	o2_percent -= 1
	food_percent -= 1
	if is_boosting:
		fuel_percent -= 4
	
	h2o_bar_fill.size.x = h2o_bar_background.size.x * h2o_percent / 100
	o2_bar_fill.size.x = o2_bar_background.size.x * o2_percent / 100
	food_bar_fill.size.x = food_bar_background.size.x * food_percent / 100
	fuel_bar_fill.size.x = fuel_bar_background.size.x * fuel_percent / 100

func init_resources_ui():
	h2o_percent = h2o_percent_ini
	o2_percent = o2_percent_ini
	food_percent = food_percent_ini
	fuel_percent = fuel_percent_ini
	
	h2o_bar_fill.size.x = h2o_bar_background.size.x * h2o_percent_ini / 100
	o2_bar_fill.size.x = o2_bar_background.size.x * o2_percent_ini / 100
	food_bar_fill.size.x = food_bar_background.size.x * food_percent_ini / 100
	fuel_bar_fill.size.x = fuel_bar_background.size.x * fuel_percent / 100
	
	
func _on_start_boosting():
	is_boosting = true

func _on_stop_boosting():
	is_boosting = false

func _on_player_departed():
	player_departed = true

func on_crash(area):
	player_departed = false
	is_boosting = false
