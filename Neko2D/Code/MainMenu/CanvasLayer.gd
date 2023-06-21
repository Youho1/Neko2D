extends CanvasLayer
@onready var main: Control = $Main


func _on_button_play_pressed():
	get_tree().change_scene_to_file("res://Scene/Main.tscn")
	pass # Replace with function body.


func _on_button_quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
