extends Spatial

var num_cams
var cams
var cam = 0

var JacksScene

# Called when the node enters the scene tree for the first time.
func _ready():
	cams = get_tree().get_nodes_in_group("Camera")
	num_cams = cams.size()
	
	JacksScene = load("res://JacksSet.tscn")
	if get_tree().get_nodes_in_group("Enemy").size() == 0:
		MusicPlayer.play_safe()
	else:
		MusicPlayer.play_main()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("NextCam"):
		cam = cam + 1
		if (cam >= num_cams):
			cam = 0
	if Input.is_action_just_pressed("PrevCam"):
		cam = cam - 1
		if (cam < 0):
			cam = cams.size() - 1
	cams[cam].make_current()

func get_cam():
	return cams[cam]


func _on_Player_throw_jacks(loc):
	var inst = JacksScene.instance()
	loc.y = loc.y + 1.2
	inst.translation = loc
	add_child(inst)
	inst.connect("jack_free", $Player, "_on_jack_free")


func _on_Endzone_body_entered(body):
	if body.is_in_group("Player"):
		get_tree().paused = true
		yield(get_tree().create_timer(1.5), "timeout")
		get_tree().paused = false
		get_tree().change_scene("res://" + SceneOrder.get_scene())
