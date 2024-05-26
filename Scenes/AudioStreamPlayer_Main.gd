extends AudioStreamPlayer

@export var delay = 0.25

var time = 3

func _ready():
	time = delay

func _process(delta):
	time -= delta
	if !playing && time <= 0.0:
		playing = true
