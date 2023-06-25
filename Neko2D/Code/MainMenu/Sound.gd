extends Node

@export var soundList : Array
var AudioPlayer : AudioStreamPlayer2D
var idx : int
func _ready():
	AudioPlayer = $AudioStreamPlayer2D
	idx = randf_range(0, soundList.size())

func _process(delta):
	if (!AudioPlayer.playing):
		AudioPlayer.stream = soundList[idx]
		AudioPlayer.play()
		idx = idx + 1
		idx = idx % soundList.size()
