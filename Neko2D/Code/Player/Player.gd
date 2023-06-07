extends Area2D

class_name Player

var speed=300
var throw_MaxN = 1
var throw_Count
var throw_slipper_posi = Vector2(20,0) #スリッパの出現場所(プレイヤーからずらす距離)
var throw_slipper_ob #実際に投げるスリッパ
var throwing_MaxF = 20
var moving_range =  Vector2.ZERO #プレイヤーが動ける範囲(上,下)
var LR_player_posi =  Vector2.ZERO #左右のプレイヤーの位置(左,右)
var leftP = true #左のプレイヤーかどうか
var while_throw_input=false


const light_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const usually_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const heavy_slipper = preload("res://Scene/Player/slipper_tmp.tscn")



# Called when the node enters the scene tree for the first time.
func _ready():
	throw_Count=0
	moving_range.x = get_node("/root/Main/left_top_player_posi").position.y
	moving_range.y = get_node("/root/Main/right_bottom_player_posi").position.y
	LR_player_posi.x = get_node("/root/Main/left_top_player_posi").position.x
	LR_player_posi.y = get_node("/root/Main/right_bottom_player_posi").position.x
	throw_slipper_ob = usually_slipper
	Set_whether_left_player(leftP)
	pass 

func _process(delta):
	var velocity=0
	
	#プレイヤーの入力
	if Input.is_action_pressed("ui_down"):
		velocity+=1
	if Input.is_action_pressed("ui_up"):
		velocity-=1
	
	#投げる入力
	if Input.is_action_just_released("ui_accept") && throw_MaxN>throw_Count:
		throw(throw_slipper_ob,throwing_MaxF)
	
	#プレイヤーの移動
	velocity = velocity*speed
	position.y+=velocity*delta
	position.y=clamp(position.y,moving_range.x,moving_range.y)

#	pass

func _input(event):
	
	pass

func throw(slipper_ob:Object,force:float): #スリッパを投げる
	var slipper = slipper_ob.instance().thrown(force,false)
	slipper.position = position + throw_slipper_posi
	
	get_node("/root/Main").add_child(slipper)
	
	throw_Count+=1
	pass

func Set_whether_left_player(left:bool): #左プレイヤーかどうか設定
	leftP=left
	if leftP:
		position.x=LR_player_posi.x
	else:
		position.x=LR_player_posi.y
	return self

