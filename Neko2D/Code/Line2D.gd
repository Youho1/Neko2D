extends Line2D
class_name draw_liner
func _ready():
	pass

func update_draw_line(player : Player, speed : float, delta : float):
	if player.throw_input == false : 
		clear_points()	
		return
	var max_points = 300
	var dir = (player.throw_posi - player.position).normalized() * 2
	clear_points()
	var pos: Vector2 = player.position
	var vel = dir * speed
	for i in max_points:
		add_point(pos)
		pos += vel * delta
