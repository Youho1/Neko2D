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
	draw_line(start, end, color,width)
	pass

func set_value(start_point:Vector2=Vector2.ZERO,end_point:Vector2=Vector2.ZERO,color:Color=Color(0,0,0),width:float=2):
	start=start_point
	end=end_point
	self.color=color
	self.width=width
	queue_redraw()
	pass
