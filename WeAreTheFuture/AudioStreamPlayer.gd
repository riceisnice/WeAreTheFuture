extends AudioStreamPlayer

var s
var m
var sf

func _ready():
	s = load("res://esprit.ogg")
	m = load("res://Troublant.ogg")
	sf = load("res://musique.ogg")

func play_splash():
	if stream != s:
		stream = s
		play()

func play_main():
	if stream != m:
		stream = m
		play()

func play_safe():
	if stream != sf:
		stream = sf
		play()
