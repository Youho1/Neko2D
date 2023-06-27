extends CanvasLayer

@onready var result : Control = $result
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	$"../Sound/Button".play()
	await WaitForSeconds(1.0)
	get_tree().change_scene_to_file("res://Scene/MainMenu/main_menu.tscn")
	pass # Replace with function body.


func _on_button_mouse_entered():
	#$"../Sound/Button".play()
	pass # Replace with function body.

func WaitForSeconds(time):
	var timer = self.get_tree().create_timer(time)
	await timer.timeout
	
