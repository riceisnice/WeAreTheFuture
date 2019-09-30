extends Spatial

const FOV = 90

export var isWalking = true
onready var follow = get_node("PathFollow")
var Player

# Called when the node enters the scene tree for the first time.
func _ready():
	set_process(true)
	Player = get_tree().get_nodes_in_group("Player")[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$PathFollow/RayCast.rotation = -$PathFollow.rotation
	if isWalking:
		follow.set_offset(follow.get_offset() + delta * 10)
	var toPlayer = Player.global_transform.origin
	toPlayer.y = 2
	toPlayer = (toPlayer  - $PathFollow/RayCast.global_transform.origin) * 2
	var tmp = toPlayer.x
	#toPlayer.x = -toPlayer.z
	toPlayer.y = 2
	#toPlayer.z = tmp
	$PathFollow/RayCast.cast_to = toPlayer
	var facing = $PathFollow.global_transform.basis.z
	if $PathFollow/RayCast.is_colliding() and $PathFollow/RayCast.get_collider() == Player and $PathFollow/FOV.overlaps_body(Player):
		print("seen")
		get_tree().paused = true
		yield(get_tree().create_timer(3), "timeout")
		get_tree().paused = false
		get_tree().reload_current_scene()

func trip():
	isWalking = false
	$AnimationTree.trip()

func walk():
	isWalking = true

