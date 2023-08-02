extends Node

@onready var h2o_bar_fill = $"../UILayer/UI/H2O_UI/H2OBarFill"
@onready var h2o_bar_background = $"../UILayer/UI/H2O_UI/H2OBarBackground"
@onready var o2_bar_fill = $"../UILayer/UI/O2_UI/O2BarFill"
@onready var o2_bar_background = $"../UILayer/UI/O2_UI/O2BarBackground"
@onready var food_bar_fill = $"../UILayer/UI/Food_UI2/FoodBarFill"
@onready var food_bar_background = $"../UILayer/UI/Food_UI2/FoodBarBackground"

var h2o_percent_ini = 100
var o2_percent_ini = 100
var food_percent_ini = 100

var h2o_percent
var o2_percent
var food_percent

func _ready():
	init_resources_ui()

func _on_resource_timer_timeout():
	h2o_percent -= 1
	o2_percent -= 1
	food_percent -= 1
	
	h2o_bar_fill.size.x = h2o_bar_background.size.x * h2o_percent / 100
	o2_bar_fill.size.x = o2_bar_background.size.x * o2_percent / 100
	food_bar_fill.size.x = food_bar_background.size.x * food_percent / 100

func init_resources_ui():
	h2o_percent = h2o_percent_ini
	o2_percent = o2_percent_ini
	food_percent = food_percent_ini
	
	h2o_bar_fill.size.x = h2o_bar_background.size.x * h2o_percent_ini / 100
	o2_bar_fill.size.x = o2_bar_background.size.x * o2_percent_ini / 100
	food_bar_fill.size.x = food_bar_background.size.x * food_percent_ini / 100
	
