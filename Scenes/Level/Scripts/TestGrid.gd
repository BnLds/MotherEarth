extends Control

@export var bg = Color(1,1,1)
@export var fg_empty = Color(0.6,0.5,0.5)
@export var fg_planet = Color(0.6,0.5,0.5)
@export var fg_start = Color(0.6,0.5,0.5)
@export var fg_target = Color(0.6,0.5,0.5)
@export var rows = 100
@export var columns = 100
@export var space_size = 200

var rect_size = Vector2(space_size, space_size)
var PlanetGenerator = preload("res://NodelessScripts/PlanetGenerator.gd")
var x
var y
var target
var origin
var centered_x = []
var centered_y = []

func _init():
	var value = PlanetGenerator.GetPointsRandom(200, space_size, space_size, 10, 50)
	x = value[0]
	y = value[1]
	origin = value[2]
	target = value[3]
	
func _ready():
	pass
	
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
	
	for i in range(rect_size.x):
		draw_rect(Rect2(Vector2(x[i], y[i]), Vector2(rect_size.x/columns, rect_size.x/columns)), fg_planet)

	#draw start planet
	draw_rect(Rect2(origin, Vector2(rect_size.x/columns, rect_size.x/columns)), fg_start)
	#draw taregt planet
	draw_rect(Rect2(target, Vector2(rect_size.x/columns, rect_size.x/columns)), fg_target)
	