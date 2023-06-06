extends Area2D


var speed = 100 #スリッパの初速

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_just_pressed("mouse_click"): #クリックを検出
		var mouse_pos = get_global_mouse_position() #カーソルの位置を取得
		var direction = mouse_pos - global_position 
		direction = direction.normalized()
		global_position += direction * speed * delta
