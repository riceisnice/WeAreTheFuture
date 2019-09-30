extends Spatial

const num_cams = 2
var cams
var cam

# Called when the node enters the scene tree for the first time.
func _ready():
	cams = [$Camera1, $Camera2]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("NextCam"):
		cam = cam + 1
		if (cam >= num_cams):
			cam = 0
		cams[cam].make_current()

func get_cam():
	return cams[cam]
