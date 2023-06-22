extends Player

var curveSlipper = true #変化球かどうか

#親クラスの関数の呼び出し方法がGodotのバージョンで違うようなので、
#もし .～～()という部分にエラーが出たら.の前にsuperと書いてみてください

func _ready():
	super._ready()
	pass # Replace with function body.


func throw(slipper_ob:Object,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	super.throw(slipper_ob,force,direction,curveSlipper) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	pass


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	super.Set_whether_left_player(left) 
	if leftP:
		scale=Vector2(-1,1)
	return self

func curve_change(curve:bool):
	curveSlipper=curve
	pass
