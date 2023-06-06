extends RigidBody2D


func _ready():
	pass # Replace with function body.

func FlyTheBall(direction : Vector2, power : float):
	direction.normalized()
	apply_central_impulse(direction * power)
	pass
