extends Control

@export var bg = Color(1,1,1)
@export var fg_empty = Color(0.6,0.5,0.5)
@export var fg_planet = Color(0.6,0.5,0.5)
@export var rows = 100
@export var columns = 100

var rect_size = Vector2(200, 200)
var PlanetGenerator = preload("res://NodelessScripts/PlanetGenerator.gd")
var value

func _init():
	value = PlanetGenerator.GetPointsRandom(200, 200, 200, 10)
	
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
		
	for i in range(0, 200):
		draw_rect(Rect2(Vector2(ceil(value[0][i]), ceil(value[1][i])), Vector2(rect_size.x/columns, rect_size.x/columns)), fg_planet)
		
