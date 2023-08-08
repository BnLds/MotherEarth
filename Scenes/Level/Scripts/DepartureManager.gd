extends Node

@onready var spaceship = $"../Spaceship"
@onready var planet = $"../Planets/Planet"

var planet_crashed

func _ready():
	spaceship.player_crashed.connect(on_player_crashed)

func _on_depart_button_pressed():
	spaceship.hide()
	if planet_crashed is PlanetManager:
		planet_crashed.show_spawn_points()
	
func on_player_crashed(area):
	planet_crashed = area

