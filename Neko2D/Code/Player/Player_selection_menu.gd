extends Node2D

var turn = true #true左 false右

const Powerful = preload("res://Scene/Player/Powerful_Cat.tscn")
const Wizard = preload("res://Scene/Player/Wizard_Cat.tscn")
const Shotgun = preload("res://Scene/Player/Shotgun_Cat.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func turn_change():
#	if !turn:
#		queue_free()
	turn=!turn
	pass


func _on_Powerful_pressed():
	playerAdd(Powerful)
	pass # Replace with function body.


func _on_Wizard_pressed():	
	playerAdd(Wizard)
	pass # Replace with function body.



func _on_Shotgun_pressed():
	playerAdd(Shotgun)
	pass # Replace with function body.

func playerAdd(player:Object):
	var player_ob = player.instantiate().Set_whether_left_player(turn)	
	get_owner().add_child(player_ob)
	turn_change()
	pass

func _on_Main_turnChange():
	pass # Replace with function body.
