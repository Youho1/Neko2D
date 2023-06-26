extends Player

var curveSlipper = true #変化球かどうか
var curveButton = preload("res://Scene/Player/curve_button.tscn")
@export var curveButton_Posi = Vector2.ZERO

func _ready():
	super._ready()
	var cButton = curveButton.instantiate()
	cButton.pressed.connect(curve_change)
	super.add_child_avoid_error(cButton,"/root/Main")
	cButton.position=curveButton_Posi
	pass # Replace with function body.


func throw(slipper_ob:Object,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	super.throw(slipper_ob,force,direction,curveSlipper) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	pass


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	super.Set_whether_left_player(left) 
	if leftP:
		$Sprite.scale*=Vector2(-1,1)
		#print("scale")
	
	#  return self 

func curve_change(curve:bool=!self.curveSlipper):
	curveSlipper=curve
	pass
