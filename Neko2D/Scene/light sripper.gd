extends Area2D
const DEFAULT_speed = 1
var speed = DEFAULT_speed

func _ready():
	pass

func _process(delta):
	var velocity = Vector2()
	var random_speed = rand_range(300, 451)
	var move = random_speed / speed 
	velocity.x += move
	position += velocity * delta
	velocity.y += move
	position += velocity * delta
