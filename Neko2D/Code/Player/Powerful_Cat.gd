extends Player

# Called when the node enters the scene tree for the first time.

#親クラスの関数の呼び出し方法がGodotのバージョンで違うようなので、
#もし .～～()という部分にエラーが出たら.の前にsuperと書いてみてください

func _ready():
#	._ready()
	throw_MaxForce=50
	pass # Replace with function body.


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	.Set_whether_left_player(left) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	if leftP:
		scale=Vector2(-1,1)
	return self
