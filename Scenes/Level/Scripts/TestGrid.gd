extends Control

@export var bg = Color(1,1,1)
@export var fg_empty = Color(0.6,0.5,0.5)
@export var fg_planet = Color(0.6,0.5,0.5)
@export var fg_start = Color(0.6,0.5,0.5)
@export var fg_target = Color(0.6,0.5,0.5)
@export var rows = 100
@export var columns = 100
@export var space_size = 100

var rect_size = Vector2(space_size, space_size)
var nbr_planets = 300
var PlanetGenerator = preload("res://NodelessScripts/PlanetGenerator.gd")
var x
var y
var target
var origin

func _init():
	var value = PlanetGenerator.GetPointsRandom(nbr_planets, space_size, space_size, 5, 30)
	x = value[0]
	y = value[1]
	origin = value[2]
	target = value[3]
	
func _draw():
	draw_rect( Rect2(Vector2.ZERO,rect_size), bg)
	
	for i in range(columns):
		var from := Vector2(i * rect_size.x/columns, 0)
		var to := Vector2(from.x, rect_size.y)
		draw_line(from, to, fg_empty)
		
	for i in range(rows):
		var from := Vector2(0, rect_size.y/rows * i)
		var to := Vector2(rect_size.x, from.y)
		draw_line(from, to, fg_empty)
	
	for i in range(nbr_planets):
		draw_rect(Rect2(Vector2(x[i], y[i]), Vector2(rect_size.x/columns, rect_size.x/columns)), fg_planet)

	#draw start planet
	draw_rect(Rect2(origin, Vector2(rect_size.x/columns, rect_size.x/columns)), fg_start)
	#draw taregt planet
	draw_rect(Rect2(target, Vector2(rect_size.x/columns, rect_size.x/columns)), fg_target)
	
