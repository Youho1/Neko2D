extends Area2D
const DEFAULT_speed = 1.5
var speed = DEFAULT_speed

func _ready():
	pass

func _process(delta):
	var velocity = Vector2()
	var random_speed = randf_range(200, 401)
	var move = random_speed / speed 
	velocity.x += move
	position += velocity * delta
	velocity.y += move
	position += velocity * delta
