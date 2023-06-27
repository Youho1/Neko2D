extends Node2D

@export var LeftPlayerPath = "../L_Player"
@export var RightPlayerPath = "../R_Player"

@export var slipper_type:PackedStringArray #プレイヤーから渡されるスリッパタイプの名前
@export var slipper_ob:Array #上の配列に対応したスリッパオブジェクト

var R_slipper:Array
var L_slipper:Array
var L_MaxNum
var R_MaxNum

# Called when the node enters the scene tree for the first time.
func _ready():
	var L_Player
	if has_node(LeftPlayerPath):
		L_Player=get_node(LeftPlayerPath)
		L_Player.throw_slipper.connect(L_throw_slipper)
		L_MaxNum = L_Player.slipper_MaxNum
	else:
		L_MaxNum=3
	
	var R_Player
	if has_node(RightPlayerPath):
		R_Player=get_node(RightPlayerPath)
		R_Player.throw_slipper.connect(R_throw_slipper)
		R_MaxNum = R_Player.slipper_MaxNum
	else:
		R_MaxNum=3
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func slipper_object_search(type:String)->int: #配列から同じ名前を探し出してidを返す
	for i in range(slipper_type.size()):
		if type==slipper_type[i]:
			return i
	return -1
	pass

func throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2):
	var id=slipper_object_search(type)
	#それぞれに対応したものを書く。今はとりあえず全部同じ
	match id:
		0,1,2:
			#スリッパの生成
			var slipper=slipper_ob[id %slipper_ob.size()].instantiate()
			add_child(slipper)
			slipper.position=posi
			slipper.thrown(force,false,direction)
			return slipper
		3:
			#スリッパの生成
			var slipper=slipper_ob[id %slipper_ob.size()].instantiate()
			add_child(slipper)
			slipper.position=posi
			slipper.thrown(force,true,direction)
			return slipper
		_:
			print("エラー")
			return null
	
	pass

func L_throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2):
	var slipper=throw_slipper(type,force,direction,posi)
	if slipper != null:
		slipper.name="L_slipper"+str(L_slipper.size())
		L_slipper.append(slipper)
		
		if L_slipper.size()>L_MaxNum:
			L_slipper[0].queue_free()
			L_slipper.remove_at(0)
			reName(L_slipper,"L_slipper")
	pass

func R_throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2):
	var slipper=throw_slipper(type,force,direction,posi)
	if slipper!=null:
		slipper.name="R_slipper"+str(R_slipper.size())
		R_slipper.append(slipper)
		
		if R_slipper.size()>R_MaxNum:
			R_slipper[0].queue_free()
			R_slipper.remove_at(0)
			reName(R_slipper,"R_slipper")
	pass

func reName(a:Array,n:String):
	for i in range(a.size()):
		a[i].name=n+str(i)
	pass
