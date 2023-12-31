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
@onready var new_ressource_label = $"../UILayer/NewRessource_UI/NewRessourceLabel"
@onready var resource_ui_timer = $ResourceUITimer

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
	h2o_bar_fill.size.x = h2o_bar_background.size.x * h2o_percent / 100
	o2_bar_fill.size.x = o2_bar_background.size.x * o2_percent / 100
	food_bar_fill.size.x = food_bar_background.size.x * food_percent / 100
	fuel_bar_fill.size.x = fuel_bar_background.size.x * fuel_percent / 100
	
	
	if not player_departed:
		return
	
	if h2o_percent != 0:
		h2o_percent -= 1
	if o2_percent != 0:
		o2_percent -= 1
	if food_percent != 0:
		food_percent -= 1
	if is_boosting && fuel_percent != 0:
		fuel_percent -= 4
	

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

func on_crash(planet):
	player_departed = false
	
	var planet_resources = planet.get_resources()
	var limiting_resource_h2o = min(planet_resources[PlanetManager.Resources.H] / 2,planet_resources[PlanetManager.Resources.O])
	h2o_percent += limiting_resource_h2o
	planet_resources[PlanetManager.Resources.H] -= limiting_resource_h2o
	planet_resources[PlanetManager.Resources.O] -= limiting_resource_h2o
	
	var o2_gain = planet_resources[PlanetManager.Resources.O] / 2
	
	o2_percent += o2_gain
	food_percent += planet_resources[PlanetManager.Resources.food]
	fuel_percent += planet_resources[PlanetManager.Resources.C]
	
	show_new_resources(
		limiting_resource_h2o,
		o2_gain,
		planet_resources[PlanetManager.Resources.food],
		planet_resources[PlanetManager.Resources.C]
		)
	
	h2o_percent = clamp(h2o_percent, 0, 100)
	o2_percent = clamp(o2_percent, 0, 100)
	food_percent = clamp(food_percent, 0, 100)
	fuel_percent = clamp(fuel_percent, 0, 100)
	
	planet.remove_resources()

func show_new_resources(h2o_quantity, o2_quantity, food_quantity, fuel_quantity):
	if(h2o_quantity != 0):
		new_ressource_label.text = "+" + str(h2o_quantity) + " H2O"
		new_ressource_label.show()
		resource_ui_timer.start()
		await resource_ui_timer.timeout
		print("h2o")
		resource_ui_timer.stop()
		new_ressource_label.hide()
		
	if(o2_quantity != 0):
		new_ressource_label.text = "+" + str(o2_quantity) + " O2"
		new_ressource_label.show()
		resource_ui_timer.start()
		await resource_ui_timer.timeout
		print("o2")
		resource_ui_timer.stop()		
		new_ressource_label.hide()
		
	if(food_quantity != 0):
		new_ressource_label.text = "+" + str(food_quantity) + " food"
		new_ressource_label.show()
		resource_ui_timer.start()
		await resource_ui_timer.timeout
		print("food")
		resource_ui_timer.stop()		
		new_ressource_label.hide()
		
	if(fuel_quantity != 0):
		new_ressource_label.text = "+" + str(fuel_quantity) + " fuel"
		new_ressource_label.show()
		resource_ui_timer.start()
		await resource_ui_timer.timeout
		print("fuel")
		resource_ui_timer.stop()		
		new_ressource_label.hide()
		
