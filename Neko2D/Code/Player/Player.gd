extends Area2D

class_name Player

signal throw_slipper(type:String,force:float,direction:Vector2,posi:Vector2)

var speed=300
var moving_range =  Vector2.ZERO #プレイヤーが動ける範囲(上,下)
var LR_player_posi =  Vector2.ZERO #左右のプレイヤーの位置(左,右)
var leftP = true #左のプレイヤーかどうか

#スキルに関する変数
var sp_timer=0.0 #ポイント回復用タイマー
var Consumed_sp = 1 #消費スキルポイント
@export var skill_point:int = 4 #スキルポイント
@export var Max_sp:int = 7 #ポイント上限
@export var add_sp_time:float = 10.0 #ポイント回復時間

var skillButton
var skillButton_ob=preload("res://Scene/Player/skill_button.tscn")
@export var sButton_parent="/root/Main"
@export var sButton_Posi = Vector2.ZERO
@export var sButton_tex : Array #PackedStringArray #ボタンを押したときに切り替えるテクスチャ
@export var skill_Consumed_sp : Array = [1]


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
var throw_slipper_type #実際に投げるスリッパ
@export var throw_slipper_posi = Vector2(20,0) #スリッパの出現場所(プレイヤーからずらす距離)(左プレイヤー基準)
@export var throw_MaxForce = 40 #投げられる最大威力
@export var slipper_MaxNum=3 #残るスリッパの数

#@export var usually_slipper = preload("res://Scene/Player/slipper_tmp.tscn")

#@export var throw_MaxN = 1 #投げられる回数
#var throw_Count = 0 #投げた数

# Called when the node enters the scene tree for the first time.
func _ready():
	#throw_Count = 0
	moving_range.x = get_node_position_avoid_error("/root/Main/left_top_player_posi").y
	moving_range.y = get_node_position_avoid_error("/root/Main/right_bottom_player_posi").y
	LR_player_posi.x = get_node_position_avoid_error("/root/Main/left_top_player_posi").x
	LR_player_posi.y = get_node_position_avoid_error("/root/Main/right_bottom_player_posi").x
	if moving_range.x==moving_range.y:
		moving_range.y=get_viewport_rect().size.y
	throw_slipper_type = "Nomal"
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
	
	if skill_Consumed_sp.size()>0:
		Consumed_sp=skill_Consumed_sp[0]
	
	pass 

func _process(delta):
	CheckActionConditions()
	_stateMachine.currentState._process(delta)
	
	sp_timer+=delta
	var add_SP=int(sp_timer/add_sp_time)
	skill_point+=add_SP
	sp_timer=sp_timer-add_sp_time*add_SP
	


func throw(slipper_ob,force:float=throw_MaxForce,direction:Vector2=Vector2(1,0),curve:bool=false): #スリッパを投げる
	#スリッパの生成
	#var slipper = slipper_ob.instantiate()
	
	#投げたプレイヤーに応じてスリッパの名前を変える
	#if leftP:
	#	slipper.name="L_"+slipper.name
	#else:
	#	slipper.name="R_"+slipper.name
	
	#add_child_avoid_error(slipper,slipper_parent)	
	#slipper.thrown(force,curve,direction)
	#slipper.position = position + throw_slipper_posi
	skill_point-=Consumed_sp
	emit_signal("throw_slipper",slipper_ob,force,direction,position + throw_slipper_posi)
	
	print(throw_slipper_type+" 力:" + str(force) + " 方向:" + str(direction.angle()))
	pass

func Set_whether_left_player(left:bool): #このプレイヤーが左プレイヤーかどうか設定
	leftP=left
	#print("set")
	if leftP:
		position.x=LR_player_posi.x
		name="L_Player"
		
		#スキルボタンの生成
		skillButton=skillButton_ob.instantiate()
		skillButton.name="skillButton"
		add_child_avoid_error(skillButton,sButton_parent)
		skillButton.position=sButton_Posi
		var sb=skillButton.get_node("Button")
		sb.set_value(sButton_tex,skill_Consumed_sp.size())
		sb.mode_change.connect(skill_mode_change)
		
	else:
		position.x=LR_player_posi.y
		throw_slipper_posi.x=-1*throw_slipper_posi.x
		name="R_Player"
	# return self

func slipper_change(slipper_type): #投げるスリッパを変える
	throw_slipper_type = slipper_type
	pass
	

func CheckActionConditions():
	canMove = !isThrowing and (Input.is_action_pressed("ui_down") or Input.is_action_pressed("ui_up"))
	
	#スペースキーなどを押しているうえでマウスボタンを押したときに(ドラック開始時)した時に投げられるようにする
	#ただマウスをドラックしたときにするとマウスでボタンを押したときなどにも反応すると思うのでスペースキーと同時押しにしました
	if  skill_point>=Consumed_sp && Input.is_action_pressed("ui_accept"): #throw_Count < throw_MaxN
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

func skilleButton_Posi_set_node(node_path:String):
	sButton_Posi=get_node_position_avoid_error(node_path)
	pass

func skilleButton_Posi_set_vector2(posi:Vector2=Vector2.ZERO):
	sButton_Posi=posi
	pass

func skill_mode_change(mode:int):
	#それぞれに対応したものを書く
	match mode:
		0:
			throw_slipper_type="Nomal"
			Consumed_sp=skill_Consumed_sp[0]
		_:
			print("エラー")
	pass

#func throw_slipper_type_set(type:String):
#	throw_slipper_type=type
#	pass
