extends Node2D

var drawLiner : draw_liner
@export var player : Player
func _ready():
	drawLiner = $Line2D
	
func _process(delta):
	drawLiner.update_draw_line(player, 20.0, delta)

