extends Area2D
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2()
	velocity.x += 75
	position += velocity * delta
	velocity.y += 75
	position += velocity * delta
