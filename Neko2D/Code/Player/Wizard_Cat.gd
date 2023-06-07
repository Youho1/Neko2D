extends Player

var curve = true

#親クラスの関数の呼び出し方法がGodotのバージョンで違うようなので、
#もし .～～()という部分にエラーが出たら.の前にsuperと書いてみてください

func _ready():
#	._ready()
	pass # Replace with function body.


func throw(slipper_ob:Object,force:float): #スリッパを投げる
	var slipper = slipper_ob.instance().thrown(force,curve)
	slipper.position = position + throw_slipper_posi
	
	get_node("/root/Main").add_child(slipper)
	
	throw_Count+=1
	pass


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	.Set_whether_left_player(left) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	return self
