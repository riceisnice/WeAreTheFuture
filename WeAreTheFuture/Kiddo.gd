extends Spatial

# Called when the node enters the scene tree for the first time.
func _ready():
	var player = get_node("AnimationPlayer")
	player.get_animation("Walk").set_loop(true)
	player.get_animation("Crouch.Walk").set_loop(true)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
