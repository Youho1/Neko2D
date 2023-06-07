extends Player

var curveSlipper = true #変化球かどうか

#親クラスの関数の呼び出し方法がGodotのバージョンで違うようなので、
#もし .～～()という部分にエラーが出たら.の前にsuperと書いてみてください

func _ready():
#	._ready()
	pass # Replace with function body.


func throw(slipper_ob:Object,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	.throw(slipper_ob,force,Vector2(1,0),curveSlipper) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	pass


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	.Set_whether_left_player(left) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	return self

func curve_change(curve:bool):
	curveSlipper=curve
	pass
