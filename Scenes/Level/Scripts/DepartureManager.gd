extends Node

@onready var spaceship = $"../Spaceship"
@onready var planet = $"../Planets/Planet"
@onready var camera_2d : CameraController = $"../Spaceship/Camera2D"

var planet_crashed
var spaceship_offset_y = 10
var spawn_sprite_offset_y = 2

func _ready():
	spaceship.player_crashed.connect(on_player_crashed)

func _on_depart_button_pressed():
	spaceship.hide()
		
	if planet_crashed is PlanetManager:
		planet_crashed.show_spawn_points()
		planet_crashed.connect("spawn_chosen", on_spawn_chosen)
	
func on_player_crashed(area):
	planet_crashed = area
	if camera_2d is CameraController:
		camera_2d.move_camera_to(area.global_position)
	
func on_spawn_chosen(sender, reference_spawn, spawn_rotation, planet_scale):
	if reference_spawn is TextureButton:
		#Get position of North spawn point
		var reference_position = reference_spawn.global_position + Vector2(reference_spawn.size.x/2 * planet_scale.x, (reference_spawn.size.y/2 + spawn_sprite_offset_y) * planet_scale.y - spaceship_offset_y)
		#rotate spawn point around the planet to get spaceship departure point
		spaceship.position = sender.global_position + (reference_position - sender.global_position).rotated(spawn_rotation)
		
	spaceship.rotation = spawn_rotation
	
	if sender is PlanetManager:
		sender.hide_spawn_points()
	if camera_2d is CameraController:
		camera_2d.reset_camera()
	
	spaceship.show()
