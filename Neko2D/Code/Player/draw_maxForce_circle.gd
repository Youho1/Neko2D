extends Node2D

class_name draw_maxForce_circle

var center:Vector2=Vector2.ZERO
var radius:float=1.0
var color:Color=Color(0,0,0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	var step = 2 * PI / (radius * 10)
	var points = []
	for angle in range(0, 2 * PI, step):
		var x = center.x + radius * cos(angle)
		var y = center.y + radius * sin(angle)
		points.append(Vector2(x, y))
		
	for index_point in range(points.size()):
		draw_line(points[index_point], points[index_point + 1], color)
	pass

func set_value(cen:Vector2=Vector2.ZERO,r:float=1.0,col:Color=Color(0,0,0)):
	center=cen
	radius=r
	color=col
	_draw()
	pass
