extends Area2D

class_name Player

var speed=300
var moving_range =  Vector2.ZERO #プレイヤーが動ける範囲(上,下)
var LR_player_posi =  Vector2.ZERO #左右のプレイヤーの位置(左,右)
var leftP = true #左のプレイヤーかどうか
var leftTurn = true #現在、左のターンかどうか
var while_throw_input=false

#スリッパに関する変数
var throw_slipper_ob #実際に投げるスリッパ
const light_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const usually_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const heavy_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
var throw_MaxN = 1 #投げられる回数
var throw_Count #投げた数
@export var throw_slipper_posi = Vector2(20,0) #スリッパの出現場所(プレイヤーからずらす距離)
@export var throw_MaxForce = 40 #投げられる最大威力

var throw_posi = Vector2.ZERO #投げる位置(ドラック入力開始地点)
var throw_input = false #投げる入力を始めているかどうか

# Called when the node enters the scene tree for the first time.
func _ready():
	throw_Count=0
	moving_range.x = get_node("/root/Main/left_top_player_posi").position.y
	moving_range.y = get_node("/root/Main/right_bottom_player_posi").position.y
	LR_player_posi.x = get_node("/root/Main/left_top_player_posi").position.x
	LR_player_posi.y = get_node("/root/Main/right_bottom_player_posi").position.x
	throw_slipper_ob = preload("res://Scene/Player/slipper_tmp.tscn")
	Set_whether_left_player(leftP)
	position.y = moving_range.x
	pass 

func _process(delta):
	#左のターンで自分が左プレイヤーの時、右のターンで自分が右プレイヤーの時のみ入力
	if (leftTurn && leftP)||(!leftTurn && !leftP):
		var velocity=0
		
		#プレイヤーの入力
		if Input.is_action_pressed("ui_down"):
			velocity+=1
		if Input.is_action_pressed("ui_up"):
			velocity-=1
		
		#プレイヤーの移動
		velocity = velocity*speed
		position.y+=velocity*delta
		position.y=clamp(position.y,moving_range.x,moving_range.y)
		
		# 投げる入力
		if throw_Count<throw_MaxN:
			if Input.is_action_pressed("ui_accept"):
				if Input.is_action_just_pressed("mouse_left"):
					# ドラッグ開始時にマウスの座標を記録
					throw_posi = get_global_mouse_position()
					throw_input=true
					print("始点:" + str(throw_posi))
				elif throw_input && Input.is_action_just_released("mouse_left"):
					# ドラッグ終了時にマウスの座標を取得し、距離と方向を計算
					var mouse_posi = get_global_mouse_position()
					var force = (mouse_posi - throw_posi).length()/5.0
					var direction = -(mouse_posi - throw_posi).normalized()
					force = clamp(force, 0.1, throw_MaxForce)
					
					if leftP && direction.x>0:
						throw(throw_slipper_ob, force, direction)
					elif !leftP && direction.x<0:
						throw(throw_slipper_ob, force, direction)
					throw_input = false
					
			else:
				throw_input = false
				
			if 
#	pass


func throw(slipper_ob:Object,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	var slipper = slipper_ob.instance().thrown(force,curve,direction)
	slipper.position = position + throw_slipper_posi
	if leftP:
		slipper.name="L_"+slipper.name
	else:
		slipper.name="R_"+slipper.name
	get_node("/root/Main").add_child(slipper)
	
	throw_Count+=1
	print("力:" + str(force) + " 方向:" + str(direction.angle()))
	pass

func Set_whether_left_player(left:bool): #左プレイヤーかどうか設定
	leftP=left
	if leftP:
		position.x=LR_player_posi.x
	else:
		position.x=LR_player_posi.y
	return self

func slipper_change(slipper_ob:Object): #投げるスリッパを変える
	throw_slipper_ob = slipper_ob
	pass
	
func turn_change(turn:bool): #投げるスリッパを変える
	leftTurn = turn
	pass

