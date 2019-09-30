extends KinematicBody

signal throw_jacks(loc)
const JACKS = 1
var used_jacks = 0

export var isWalking = false
export var isCrouched = false
var speed

var gravity = -9.8
var velocity = Vector3()
var camera

const TALLSPEED = 6
const CROUCHSPEED = 4
const ACC = 3
const DEACC = 5

# Called when the node enters the scene tree for the first time.
func _ready():
	speed = TALLSPEED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var dir = Vector3()
	camera = get_parent().get_cam().get_global_transform()
	
	if Input.is_action_just_pressed("Crouch"):
		isCrouched = !isCrouched
		if isCrouched:
			speed = CROUCHSPEED
		else:
			speed = TALLSPEED

	isWalking = false
	if Input.is_action_pressed("FW"):
		dir += -camera.basis[2]
		isWalking = true
	if Input.is_action_pressed("BW"):
		dir += camera.basis[2]
		isWalking = true
	if Input.is_action_pressed("L"):
		dir += -camera.basis[0]
		isWalking = true
	if Input.is_action_pressed("R"):
		dir += camera.basis[0]
		isWalking = true
	
	dir.y = 0
	dir = dir.normalized()
	
	velocity.y += delta * gravity
	
	var hv = velocity
	hv.y = 0
	
	var new_pos = dir * speed
	var accel = DEACC
	
	if (dir.dot(hv) > 0):
		accel = ACC
	
	hv = hv.linear_interpolate(new_pos, accel * delta)
	
	velocity.x = hv.x
	velocity.z = hv.z
	
	velocity = move_and_slide(velocity, Vector3(0,1,0))
	
	if isWalking:
		var angle = atan2(hv.x, hv.z)
		
		var char_rot = get_node("Kiddo").get_rotation()
		
		char_rot.y = angle
		get_node("Kiddo").set_rotation(char_rot)
	
	if Input.is_action_just_pressed("item"):
		used_jacks = used_jacks + 1
		if used_jacks <= JACKS:
			emit_signal("throw_jacks", $Kiddo/RayCast.get_collision_point())

func _on_jack_free():
	used_jacks = used_jacks - 1