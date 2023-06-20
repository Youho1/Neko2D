extends "res://Code/Player/PlayerState.gd"

class_name PlayerThrowState

func _init(player:Player, stateMachine:PlayerStateMachine, anim:String):
	super._init(player, stateMachine, anim)

func _Enter():
	super._Enter()

func _process(delta):
	super._process(delta)
	if not _player.canThrow:
		_stateMachine.ChangeState(_player.idleState)
		
	if Input.is_action_just_pressed("mouse_left"):
		# ドラッグ開始時にマウスの座標を記録
		_player.throw_posi = _player.get_global_mouse_position()
		_player.throw_input=true
		print("始点:" + str(_player.throw_posi))
	elif _player.throw_input && Input.is_action_just_released("mouse_left"):
		# ドラッグ終了時にマウスの座標を取得し、距離と方向を計算
		var mouse_posi = _player.get_global_mouse_position()
		var force = (mouse_posi - _player.throw_posi).length()/5.0
		var direction = -(mouse_posi - _player.throw_posi).normalized()
		force = clamp(force, 0.1, _player.throw_MaxForce)
					
		if _player.leftP && direction.x>0:
			_player.throw(_player.throw_slipper_ob, force, direction)
		elif !_player.leftP && direction.x<0:
			_player.throw(_player.throw_slipper_ob, force, direction)
			_player.throw_input = false
		else:
			_player.throw_input = false
	pass

func _Exit():
	super._Exit()
