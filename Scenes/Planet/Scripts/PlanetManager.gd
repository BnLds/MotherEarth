extends Area2D
class_name PlanetManager

enum Resources 
{
	O,
	H,
	C,
	food,
	clue
}

@export var is_start_planet : bool = false
@export_range (1, 5) var planet_abundance : int = 2
@export var O_quantity: int = 0
@export var H_quantity: int = 0
@export var C_quantity: int = 0
@export var food_quantity: int = 0
@export var has_clue := false
@export var radius : int = 100

@onready var spawn_points = $PlanetSprite/SpawnPoints
@onready var planet_shape = $PlanetShape
@onready var planet_sprite = $PlanetSprite
@onready var north_spawn = $PlanetSprite/SpawnPoints/NorthSpawn

var planet_scale

signal spawn_chosen

func _init():
	#define how many different resources the planet will have
	planet_abundance = int(clamp(randfn(2, 1), 1, Resources.size()))
	
	var available_resources = []	
	var new_resource = -1
	var allocated_resources = [-1]
	for i in range(planet_abundance):
		while(new_resource in allocated_resources):
			new_resource = randi_range(0, Resources.size())
		available_resources.append(new_resource)
		allocated_resources.append(new_resource)
	
	for resource in available_resources:
		match(resource):
			Resources.O:
				O_quantity = int(clamp(randfn(50, 15), 0, 100))
			Resources.H:
				H_quantity = int(clamp(randfn(50, 15), 0, 100))
			Resources.C:
				C_quantity = int(clamp(randfn(50, 15), 0, 100))
			Resources.food:
				food_quantity = int(clamp(randfn(50, 15), 0, 100))
			Resources.clue:
				has_clue= true

	
func _ready():
	radius = planet_abundance * 50
	planet_shape.shape.radius = radius
	spawn_points.connect("spawn_pressed", on_spawn_chosen)
	
	var sprite_width = planet_sprite.texture.get_width()
	planet_scale = Vector2.ONE * float(radius) / float(sprite_width/2)
	planet_sprite.scale = planet_scale

func show_spawn_points():
	spawn_points.show()

func hide_spawn_points():
	spawn_points.hide()

func on_spawn_chosen(spawn_rotation):
	spawn_chosen.emit(self, north_spawn, spawn_rotation, planet_scale)

func get_north_spawn():
	return north_spawn
	
func get_sprite_scale():
	return planet_scale

func get_resources():
	return {Resources.O : O_quantity, Resources.H : H_quantity, Resources.C : C_quantity, Resources.food : food_quantity, Resources.clue : has_clue}

func remove_resources():
	O_quantity = 0
	H_quantity = 0
	C_quantity = 0
	food_quantity = 0
	has_clue = false
