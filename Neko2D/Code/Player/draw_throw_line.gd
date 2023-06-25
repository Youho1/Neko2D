extends Node2D

class_name draw_throw_line

var start:Vector2=Vector2.ZERO
var end:Vector2=Vector2.ZERO
var color:Color=Color(0,0,0)
var width:float=1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _draw():
	#draw_line(start, end, color,width)
	var points = PackedVector2Array()
	var d=(end-start).normalized()
	points.append(end)	
	points.append(start+Vector2(d.y,-d.x)*width/2)
	points.append(start+Vector2(-d.y,d.x)*width/2)
	draw_polygon(points,PackedColorArray([color]))
	pass

func set_value(start_point:Vector2=self.start,end_point:Vector2=self.end,color:Color=self.color,width:float=self.width):
	start=start_point
	end=end_point
	self.color=color
	self.width=width
	queue_redraw()
	pass
