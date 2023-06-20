extends Area2D
const DEFAULT_speed = 500
var speed = DEFAULT_speed

func _ready():
	pass

func _process(delta):
	var velocity = Vector2()
	var random_y = rand_range(0, 401)
	velocity.x += speed
	position += velocity * delta
	velocity.y += random_y
	position += velocity * delta
