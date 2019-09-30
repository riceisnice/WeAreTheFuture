extends Area

signal enemy_entered
signal jack_free

var jacks
var freed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	jacks = get_tree().get_nodes_in_group("Jack").size()

func _on_JacksSet_body_exited(body):
	if body.is_in_group("Jack"):
		jacks = jacks - 1
		if jacks <= 0:
			yield(get_tree().create_timer(0.5), "timeout")
			if (!freed):
				emit_signal("jack_free")
				queue_free()


func _on_JacksSet_body_entered(body):
		body = body.get_parent().get_parent()
		if body.is_in_group("Enemy"):
			emit_signal("enemy_entered")
			body.trip()
			yield(get_tree().create_timer(3), "timeout")
			if (!freed):
				emit_signal("jack_free")
				queue_free()


func _on_JacksSet_jack_free():
	freed = true
