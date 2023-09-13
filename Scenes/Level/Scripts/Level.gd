extends Node2D


@onready var planets = $Planets
@onready var spaceship = $Spaceship
@onready var departure_manager = $DepartureManager

#Planet Generation parameters
@export var rows = 100
@export var columns = 100
@export var space_size = 100
@export var planet_scene : PackedScene
var nbr_planets = 300
var min_dist_planets = 3
var min_dist_target = 30
var rect_size = Vector2(space_size, space_size)
var PlanetGenerator = preload("res://NodelessScripts/PlanetGenerator.gd")


var screen_width = ProjectSettings.get_setting("display/window/size/viewport_width")
var screen_height = ProjectSettings.get_setting("display/window/size/viewport_height")
var x
var y
var origin_coordinates
var target_coordinates
var target_position
var signal_emitted := false 

signal initialization_complete

func _init():
	var value = PlanetGenerator.GetPointsRandom(nbr_planets, space_size, space_size, min_dist_planets, min_dist_target)
	x = value[0]
	y = value[1]
	origin_coordinates = value[2]
	target_coordinates = value[3]

func _ready():
	for i in range(nbr_planets):
		var new_planet = planet_scene.instantiate()
		new_planet.position = Vector2(screen_width * (x[i] + 0.5) + randf_range(0.0, 10.0), screen_height * (y[i] + 0.5) + randf_range(0.0, 10.0))
		planets.add_child(new_planet) 
		
		if x[i]== origin_coordinates[0] && y[i] == origin_coordinates[1]:
			new_planet.is_start_planet = true
			if departure_manager is DepartureManager:
				departure_manager.position_player_on_spawn(new_planet, new_planet.get_north_spawn(), 0, new_planet.get_sprite_scale())
				target_position = new_planet.position
				
		if x[i]== target_coordinates[0] && y[i] == target_coordinates[1]:
			target_position = new_planet.position

func _process(delta):
	if not signal_emitted:
		initialization_complete.emit(target_position)
		signal_emitted = true
		

func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().reload_current_scene()
