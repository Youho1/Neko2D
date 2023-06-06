extends Area2D

export var initial_speed = 300  # 初期速度
export var decay_rate = 10  # 速度の減衰率

var target_position = Vector2.ZERO  # クリックされた位置
var velocity = Vector2.ZERO  # 対象の速度ベクトル

func _process(delta):
	# クリックされたときの処理
	if Input.is_action_just_pressed("mouse_click"):
		target_position = get_global_mouse_position()
		velocity = (target_position - position).normalized() * initial_speed

	# 対象の移動
	position += velocity * delta

	# 速度の減衰
	if velocity != Vector2.ZERO:
		velocity -= velocity * decay_rate * delta
