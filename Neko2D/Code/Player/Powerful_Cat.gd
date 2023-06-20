extends Player

# Called when the node enters the scene tree for the first time.

#親クラスの関数の呼び出し方法がGodotのバージョンで違うようなので、
#もし .～～()という部分にエラーが出たら.の前にsuperと書いてみてください

func _ready():
	super._ready()
	pass # Replace with function body.


func Set_whether_left_player(left): #左プレイヤーかどうか設定
	super.Set_whether_left_player(left) #もしこの部分にエラーが出たら . の前にsuperと書いてみてください
	return self
