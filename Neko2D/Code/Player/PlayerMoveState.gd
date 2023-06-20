extends "res://Code/Player/PlayerState.gd"

class_name  PlayerMoveState
func _init(player : Player, stateMachine : PlayerStateMachine, anim : String):
	super._init(player, stateMachine, anim)

func _Enter():
	super._Enter()

func _process(delta):
	super._process(delta)
	if not _player.canMove:
		_stateMachine.ChangeState(_player.idleState)
	#移動処理
	var velocity=0
	
	#プレイヤーの入力
	if Input.is_action_pressed("ui_down"):
		velocity+=1
	if Input.is_action_pressed("ui_up"):
		velocity-=1
	
	#プレイヤーの移動
	velocity = velocity*_player.speed
	_player.position.y+=velocity*delta
	_player.position.y=clamp(_player.position.y,_player.moving_range.x,_player.moving_range.y)
	
func _Exit():
	super._Exit()
