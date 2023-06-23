extends "res://Code/Player/PlayerState.gd"

class_name PlayerThrowState
var throw_input_posi = Vector2.ZERO #ドラック入力開始地点
var Dividing_factor = 5.0#ドラック距離を力に変換するときの除算係数

var throw_line #投げる方向を描写するノード
var line_width=1 #線の太さ
var line_color=Color(0,0,0) #線の色
var line_length=100 #線の長さ
var maxForce_circle #ドラック時に力の最大値を表示する円を描写するノード

func _init(player:Player, stateMachine:PlayerStateMachine, anim:String):
	super._init(player, stateMachine, anim)

func _Enter():
	super._Enter()
	_player.isThrowing = true
	# 入力開始時(ドラック開始時)にマウスの座標を記録
	throw_input_posi = _player.get_global_mouse_position()
	print("始点:" + str(throw_input_posi))
	
	line_width=1
	line_color=Color(0,0,0)
	
	var main = "/root/Main"
	throw_line= Node2D.new()
	throw_line.name="throw_line"
	_player.add_child(throw_line)
	maxForce_circle=draw_maxForce_circle.new()
	maxForce_circle.name="maxForce_circle"
	_player.add_child_avoid_error(maxForce_circle,main)
	
	#maxForce_circle.set_value(throw_input_posi,_player.throw_MaxForce*Dividing_factor)

func _process(delta):
	super._process(delta)
	if not _player.canThrow:
		_stateMachine.ChangeState(_player.idleState)
	else:
		var mouse_posi = _player.get_global_mouse_position()
		var force = (mouse_posi - throw_input_posi).length()/Dividing_factor #マウスをドラックした距離から力を計算する
		var direction = -(mouse_posi - throw_input_posi).normalized() #マウスをドラックした角度から投げる方向を決める(パチンコのように移動した方向と逆)
		
		#throw_line.draw_line(Vector2.ZERO,direction*line_length,line_color,line_width)
		
		if _player.isThrowing && Input.is_action_just_released("mouse_left"):
			# ドラッグ終了時(ボタンを離したとき)
			
			#var force = 50
			#var direction = (throw_input_posi - _player.position).normalized()
			force = clamp(force, 0.1, _player.throw_MaxForce) #力が大きくなりすぎないようにする
			
			#画面の内側にしか投げられないようにする
			if (_player.leftP && direction.x>0)||(!_player.leftP && direction.x<0): #左プレイヤーの時は右方向に、右プレイヤーの時は左方向にしか投げない
				_player.throw(_player.throw_slipper_ob, force, direction)
				_player.throw_Count += 1
				_player.canThrow = false #入力を終わりにする
				
			else: #画面の外側に投げようとしている時、入力をキャンセルする
				_player.canThrow = false
				
			#_player.throw(_player.throw_slipper_ob, force, direction)
			
	pass

func _Exit():
	super._Exit()
	_player.isThrowing = false
	print(_player.throw_Count)
