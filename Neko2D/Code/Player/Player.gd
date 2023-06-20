extends Area2D

class_name Player

var speed=300
var moving_range =  Vector2.ZERO #プレイヤーが動ける範囲(上,下)
var LR_player_posi =  Vector2.ZERO #左右のプレイヤーの位置(左,右)
var leftP = true #左のプレイヤーかどうか
var leftTurn = true #現在、左のターンかどうか
var while_throw_input=false

var _stateMachine : PlayerStateMachine
var idleState : PlayerIdleState
var moveState : PlayerMoveState
var throwState : PlayerThrowState
var canMove : bool
var canThrow : bool
var isMoving : bool
var isThrowing : bool

#スリッパに関する変数
var throw_slipper_ob #実際に投げるスリッパ
const light_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const usually_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const heavy_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
var throw_MaxN = 1 #投げられる回数
var throw_Count = 0#投げた数
@export var throw_slipper_posi = Vector2(20,0) #スリッパの出現場所(プレイヤーからずらす距離)
@export var throw_MaxForce = 40 #投げられる最大威力

var throw_posi = Vector2.ZERO #投げる位置(ドラック入力開始地点)
var throw_input = false #投げる入力を始めているかどうか

# Called when the node enters the scene tree for the first time.
func _ready():
	throw_Count=0
	moving_range.x = get_node("/root/Main/left_top_player_posi").position.x
	moving_range.y = get_node("/root/Main/right_bottom_player_posi").position.y
	LR_player_posi.x = get_node("/root/Main/left_top_player_posi").position.x
	LR_player_posi.y = get_node("/root/Main/right_bottom_player_posi").position.x
	throw_slipper_ob = preload("res://Scene/Player/slipper_tmp.tscn")
	Set_whether_left_player(leftP)
	position.y = moving_range.x
	
	isMoving = false
	isThrowing = false
	_stateMachine = PlayerStateMachine.new()
	idleState = PlayerIdleState.new(self, _stateMachine, "Idle")
	moveState = PlayerMoveState.new(self, _stateMachine, "Move")
	throwState = PlayerThrowState.new(self, _stateMachine, "Throw")
	_stateMachine.Initialize(idleState)
	pass 

func _process(delta):
	CheckActionConditions()
	_stateMachine.currentState._process(delta)
			
#	pass


func throw(slipper_ob:Object,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	var slipper = slipper_ob.instantiate().thrown(force,curve,direction)
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
	
func turn_change(turn:bool): #現在のターン
	leftTurn = turn
	pass

func CheckActionConditions():
	canMove = !isThrowing and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"))
	canThrow = !isThrowing and Input.is_action_pressed("ui_accept") and throw_Count < throw_MaxN and (leftTurn && leftP) || (!leftTurn && !leftP)
	pass
