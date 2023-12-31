extends Node2D

@onready var east_spawn = $EastSpawn
@onready var west_spawn = $WestSpawn
@onready var north_spawn = $NorthSpawn
@onready var south_spawn = $SouthSpawn

signal spawn_pressed

func _on_east_spawn_pressed():
	spawn_pressed.emit(east_spawn.rotation)


func _on_west_spawn_pressed():
	spawn_pressed.emit(west_spawn.rotation)


func _on_north_spawn_pressed():
	spawn_pressed.emit(north_spawn.rotation)


func _on_south_spawn_pressed():
	spawn_pressed.emit(south_spawn.rotation)
