extends Node2D


@onready var planets = $Planets

#Planet Generation parameters
@export var rows = 100
@export var columns = 100
@export var space_size = 100
@export var planet_scene : PackedScene
var nbr_planets = 300
var min_dist_planets = 5
var min_dist_target = 30
var rect_size = Vector2(space_size, space_size)
var PlanetGenerator = preload("res://NodelessScripts/PlanetGenerator.gd")


var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var x
var y
var target
var origin


func _init():
	var value = PlanetGenerator.GetPointsRandom(nbr_planets, space_size, space_size, min_dist_planets, min_dist_target)
	x = value[0]
	y = value[1]
	origin = value[2]
	target = value[3]

func _ready():
	for i in range(nbr_planets):
		var new_planet = planet_scene.instantiate()
		new_planet.position = Vector2(screen_width * (x[i] + 0.5), screen_height * (y[i] + 0.5))
		planets.add_child(new_planet) 

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
