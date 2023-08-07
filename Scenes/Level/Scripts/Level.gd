extends Node2D

@export var rows = 100
@export var columns = 100
@export var space_size = 200
@export var planet_scene : PackedScene

@onready var planets = $Planets

var rect_size = Vector2(space_size, space_size)
var PlanetGenerator = preload("res://NodelessScripts/PlanetGenerator.gd")
var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var x
var y
var target
var origin

func _init():
	var value = PlanetGenerator.GetPointsRandom(200, space_size, space_size, 10, 50)
	x = value[0]
	y = value[1]
	origin = value[2]
	target = value[3]

func _ready():
	for i in range(space_size):
		var new_planet = planet_scene.instantiate()
		new_planet.position = Vector2(screen_width * (x[i] + 0.5), screen_height * (y[i] + 0.5))
		planets.add_child(new_planet) 

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
