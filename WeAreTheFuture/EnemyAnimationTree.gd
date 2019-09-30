extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
var Player

func _ready():
	playback = get("parameters/playback")
	playback.start("Walk-loop")
	Player = get_parent()
	active = true

func trip():
	playback.travel("Walk-loop 2")

func _process(delta):
	if playback.get_current_node() == "Walk-loop 2":
		print("reset")
		playback.travel("Walk-loop")
		Player.walk()
