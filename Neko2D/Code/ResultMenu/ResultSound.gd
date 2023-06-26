extends Node
@export var PlayerWon : bool
var played = false
var ResultLabel

func _ready():
	ResultLabel = $"../CanvasLayer/result/CenterContainer/Label"
	
func _process(delta):
	if PlayerWon == true && !$Win.playing && !$GameOver.playing && !played:
		# 勝利のSE
		$Win.play()
		# 一回再生したら、もう再生しません
		played = true
		# 勝利のメッセージ
		ResultLabel.text = "You are Won!"
	elif PlayerWon == false && !$Win.playing && !$GameOver.playing  && !played:
		# 失敗のSE
		$GameOver.play()
		# 一回再生したら、もう再生しません
		played = true
		# 失敗のメッセージ
		ResultLabel.text = "Game Over!"
