extends AnimationTree

var playback : AnimationNodeStateMachinePlayback
var Player

func _ready():
	playback = get("parameters/playback")
	playback.start("Idle")
	Player = get_parent()
	active = true

func _process(delta):
	if Player.isCrouched:
		if Player.isWalking:
			playback.travel("Crouch.Walk")
		else:
			playback.travel("Crouch.Idle")
	else:
		if Player.isWalking:
			playback.travel("Walk")
		else:
			playback.travel("Idle")