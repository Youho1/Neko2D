extends Player

# Called when the node enters the scene tree for the first time.

#親クラスの関数の呼び出し方法がGodotのバージョンで違うようなので、
#もし .～～()という部分にエラーが出たら.の前にsuperと書いてみてください

func _ready():
	._ready()
	throwing_MaxF=40
	pass # Replace with function body.


func throw(slipper_ob:Object,force:float): #スリッパを投げる
	.throw(slipper_ob,force) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	pass


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	.Set_whether_left_player(left) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	if leftP:
		scale=Vector2(-1,1)
	return self
