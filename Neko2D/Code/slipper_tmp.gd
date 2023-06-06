extends Area2D

var thrown_force = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func thrown(force:float,curve:bool):
	thrown_force = force
	print("thrown"+str(force)+"curve:"+str(curve))
	return self

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
