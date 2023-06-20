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
	
func _Exit():
	super._Exit()
