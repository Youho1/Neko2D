extends RigidBody2D
class_name Ball
func _ready():
	pass # Replace with function body.

func FlyTheBall(direction : Vector2, power : float):
	direction.normalized()
	apply_central_impulse(direction * power)
	var position = self.transform.origin
	
	pass


func _on_body_entered(body):
	var name = body.name
	if body.is_in_group("Slipper"):
		# Slipper method callback
		return
	pass # Replace with function body.
