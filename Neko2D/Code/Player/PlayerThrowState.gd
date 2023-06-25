extends "res://Code/Player/PlayerState.gd"

class_name PlayerThrowState
var throw_input_posi = Vector2.ZERO #ドラック入力開始地点
var Dividing_factor = 5.0#ドラック距離を力に変換するときの除算係数

var throw_line #投げる方向を描写するノード
var line_MaxWidth=50 #線の太さ上限
var line_MinWidth=1 #線の太さ下限
var line_color=Color(255,255,255,0.8) #線の色
var line_length=100 #線の長さ

var maxForce_circle #ドラック時に力の最大値を表示する円を描写するノード

var mouse_circle #ドラック時にマウスの位置に円を描画するノード
var circle_MaxR=80 #半径の太さ上限
var circle_MinR=1 #半径の太さ下限
var circle_color=Color(255,255,255,0.8)

func _init(player:Player, stateMachine:PlayerStateMachine, anim:String):
	super._init(player, stateMachine, anim)

func _Enter():
	super._Enter()
	_player.isThrowing = true
	# 入力開始時(ドラック開始時)にマウスの座標を記録
	throw_input_posi = _player.get_global_mouse_position()
	print("始点:" + str(throw_input_posi))
	
	line_MaxWidth=10
	line_MinWidth=1
	line_color=Color(255,255,255,0.8)
	
	circle_MaxR=100
	circle_MinR=1
	circle_color=Color(255,255,255,0.8)
	
	var main = "/root/Main"
	throw_line= draw_throw_line.new()
	throw_line.name="throw_line"
	_player.add_child(throw_line)
	throw_line.set_value(_player.throw_slipper_posi,_player.throw_slipper_posi,line_color,line_MinWidth)
	
	maxForce_circle=draw_maxForce_circle.new()
	maxForce_circle.name="maxForce_circle"
	_player.add_child_avoid_error(maxForce_circle,main)
	maxForce_circle.set_value(throw_input_posi,_player.throw_MaxForce*Dividing_factor,Color(255,255,255,0.5),5)
	
	mouse_circle=throw_mouseCircle.new()
	mouse_circle.name="mouse_circle"
	_player.add_child_avoid_error(mouse_circle,main)
	mouse_circle.set_value(throw_input_posi,circle_MinR,circle_color)

func _process(delta):
	super._process(delta)
	if not _player.canThrow:
		_stateMachine.ChangeState(_player.idleState)
	else:
		var mouse_posi = _player.get_global_mouse_position()
		var force = (mouse_posi - throw_input_posi).length()/Dividing_factor #マウスをドラックした距離から力を計算する
		var direction = -(mouse_posi - throw_input_posi).normalized() #マウスをドラックした角度から投げる方向を決める(パチンコのように移動した方向と逆)
		
		force = clamp(force, 0.1, _player.throw_MaxForce) #力が大きくなりすぎないようにする
		
		var line_width=force/_player.throw_MaxForce*(line_MaxWidth-line_MinWidth)+line_MinWidth #0~maxForceの値をline_MinWidth~line_MaxWidthにする
		throw_line.set_value(_player.throw_slipper_posi,direction*line_length,line_color,line_width)
		
		var circle_R=force/_player.throw_MaxForce*(circle_MaxR-circle_MinR)+circle_MinR #0~maxForceの値をcircleの上限下限にする
		var mouse_circle_posi=mouse_posi
		if mouse_circle_posi.distance_to(throw_input_posi)>(_player.throw_MaxForce*Dividing_factor):
			mouse_circle_posi=throw_input_posi+(mouse_posi-throw_input_posi).normalized()*_player.throw_MaxForce*Dividing_factor
		#mouse_circle_posi.x = clamp(mouse_posi.x,(throw_input_posi.x-_player.throw_MaxForce*Dividing_factor),(throw_input_posi.x+_player.throw_MaxForce*Dividing_factor))
		#mouse_circle_posi.y = clamp(mouse_posi.y,(throw_input_posi.y-_player.throw_MaxForce*Dividing_factor),(throw_input_posi.y+_player.throw_MaxForce*Dividing_factor))
		mouse_circle.set_value(mouse_circle_posi,circle_R)
		
		if _player.isThrowing && Input.is_action_just_released("mouse_left"):
			# ドラッグ終了時(ボタンを離したとき)
			
			#var force = 50
			#var direction = (throw_input_posi - _player.position).normalized()
			
			
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
	maxForce_circle.queue_free()
	throw_line.queue_free()
	mouse_circle.queue_free()
	print(_player.throw_Count)
