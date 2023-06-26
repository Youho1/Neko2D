extends Node2D

@export var LeftPlayerPath = "../L_Player"
@export var RightPlayerPath = "../R_Player"

@export var slipper_type:PackedStringArray #プレイヤーから渡されるスリッパタイプの名前
@export var slipper_ob:Array #上の配列に対応したスリッパオブジェクト

var R_slipper:Array
var L_slipper:Array

# Called when the node enters the scene tree for the first time.
func _ready():
	var L_Player
	if has_node(LeftPlayerPath):
		L_Player=get_node(LeftPlayerPath)
		L_Player.throw_slipper.connect(L_throw_slipper)
	
	var R_Player
	if has_node(RightPlayerPath):
		R_Player=get_node(RightPlayerPath)
		R_Player.throw_slipper.connect(R_throw_slipper)
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

func throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2)->Object:
	var id=slipper_object_search(type)
	#それぞれに対応したものを書く。今はとりあえず全部同じ
	match id:
		0,1,2:
			#スリッパの生成
			var slipper=slipper_ob[id %slipper_ob.size()].instantiate()
			add_child(slipper)
			slipper.position=posi
			slipper.thrown(force,false,direction)
		3:
			#スリッパの生成
			var slipper=slipper_ob[id %slipper_ob.size()].instantiate()
			add_child(slipper)
			slipper.position=posi
			slipper.thrown(force,true,direction)
		_:
			print("エラー")
	return null
	pass

func L_throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2):
	var slipper=throw_slipper(type,force,direction,posi)
	if slipper!=null:
		L_slipper.append(slipper)
	pass

func R_throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2):
	var slipper=throw_slipper(type,force,direction,posi)
	if slipper!=null:
		R_slipper.append(slipper)
	pass
