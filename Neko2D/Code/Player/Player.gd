extends Area2D

class_name Player

var speed=300
var moving_range =  Vector2.ZERO #プレイヤーが動ける範囲(上,下)
var LR_player_posi =  Vector2.ZERO #左右のプレイヤーの位置(左,右)
var leftP = true #左のプレイヤーかどうか


#状態遷移に関する変数
var _stateMachine : PlayerStateMachine
var idleState : PlayerIdleState
var moveState : PlayerMoveState
var throwState : PlayerThrowState
var canMove : bool
var canThrow : bool
var isMoving : bool
var isThrowing : bool

#スリッパに関する変数
@export var slipper_parent="/root/Main" #生成したスリッパの親のノード
var throw_slipper_ob #実際に投げるスリッパ
const light_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const usually_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
const heavy_slipper = preload("res://Scene/Player/slipper_tmp.tscn")
@export var throw_MaxN = 1 #投げられる回数
var throw_Count = 0 #投げた数
@export var throw_slipper_posi = Vector2(20,0) #スリッパの出現場所(プレイヤーからずらす距離)(左プレイヤー基準)
@export var throw_MaxForce = 40 #投げられる最大威力

# Called when the node enters the scene tree for the first time.
func _ready():
	throw_Count=0	
	moving_range.x = get_node_position_avoid_error("/root/Main/left_top_player_posi").y
	moving_range.y = get_node_position_avoid_error("/root/Main/right_bottom_player_posi").y
	LR_player_posi.x = get_node_position_avoid_error("/root/Main/left_top_player_posi").x
	LR_player_posi.y = get_node_position_avoid_error("/root/Main/right_bottom_player_posi").x
	if moving_range.x==moving_range.y:
		moving_range.y=get_viewport_rect().size.y
	throw_slipper_ob = preload("res://Scene/Player/slipper_tmp.tscn")
	#print("ready")
	#Set_whether_left_player(leftP)
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
	


func throw(slipper_ob:Object,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	#スリッパの生成
	var slipper = slipper_ob.instantiate()
	
	#投げたプレイヤーに応じてスリッパの名前を変える
	if leftP:
		slipper.name="L_"+slipper.name
	else:
		slipper.name="R_"+slipper.name
	
	add_child_avoid_error(slipper,slipper_parent)	
	slipper.thrown(force,curve,direction)
	slipper.position = position + throw_slipper_posi
	
	#throw_Count+=1
	print("力:" + str(force) + " 方向:" + str(direction.angle()))
	pass

func Set_whether_left_player(left:bool): #このプレイヤーが左プレイヤーかどうか設定
	leftP=left
	print("set")
	if leftP:
		position.x=LR_player_posi.x
	else:
		position.x=LR_player_posi.y
		throw_slipper_posi.x=-1*throw_slipper_posi.x
	# return self

func slipper_change(slipper_ob:Object): #投げるスリッパを変える
	throw_slipper_ob = slipper_ob
	pass
	

func CheckActionConditions():
	canMove = !isThrowing and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"))
	
	#スペースキーなどを押しているうえでマウスボタンを押したときに(ドラック開始時)した時に投げられるようにする
	#ただマウスをドラックしたときにするとマウスでボタンを押したときなどにも反応すると思うのでスペースキーと同時押しにしました
	if throw_Count < throw_MaxN && Input.is_action_pressed("ui_accept"):
		if Input.is_action_just_pressed("mouse_left"):
			canThrow=true
	else: #マウスのボタンを離すより先にスペースキーが離されたとき入力をキャンセルする
		canThrow=false
	
	pass


func get_node_position_avoid_error(path:String) -> Vector2: #ノードがなくエラーが起きる対策。返すものはpathのノードのposition
	if has_node(path):
		#print(get_node(path).position)
		return get_node(path).position
	else:
		return Vector2.ZERO
	pass

func add_child_avoid_error(child,path:String="/root"): #add_childのエラーよけ
	#設定した親(path)のノードがなかったら単にrootの子供にする
	if has_node(path):
		get_node(path).add_child(child)
	else:
		get_node("/root").add_child(child)
		print(path+" が見つかりません。/root に生成しました")
	pass

