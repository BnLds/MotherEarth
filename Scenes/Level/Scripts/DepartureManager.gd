extends Node
class_name DepartureManager

@onready var spaceship = $"../Spaceship"
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
		camera_2d.move_camera_on_planet(area.global_position)
	
func on_spawn_chosen(sender, reference_spawn, spawn_rotation, planet_scale):
	position_player_on_spawn(sender, reference_spawn, spawn_rotation, planet_scale)
	
	if sender is PlanetManager:
		sender.hide_spawn_points()
	if camera_2d is CameraController:
		camera_2d.reset_camera()
	
	spaceship.show()
	
func position_player_on_spawn(planet, ref_spawn, spawn_angle, planet_scale):
	if ref_spawn is TextureButton:
		#Get position of North spawn point
		var reference_position = ref_spawn.global_position + Vector2(ref_spawn.size.x/2 * planet_scale.x, (ref_spawn.size.y/2 + spawn_sprite_offset_y) * planet_scale.y - spaceship_offset_y)
		#rotate spawn point around the planet to get spaceship departure point
		spaceship.position = planet.global_position + (reference_position - planet.global_position).rotated(spawn_angle)
		
	spaceship.rotation = spawn_angle
		
