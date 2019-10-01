extends Node

var scenes = ["Splash.tscn", "PillarRoom.tscn", "Hallway.tscn", "Room2.tscn"]
var index = 1

func _ready():
	pass # Replace with function body.

func get_scene():
	var s = scenes[index]
	index += 1
	if index >= scenes.size():
		index = 0
	return s
