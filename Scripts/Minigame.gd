extends Node2D

class_name Minigame

@export var max_time = 5.0
var parent_game : Node2D = null
var score_set = false
var time : float = 1.0

func _ready():
	time = max_time

func _process(delta):
	time -= delta
	if parent_game != null:
		parent_game.update_time(time)
	if time <= 0.0:
		_set_score(0.0)
		if parent_game == null:
			get_tree().quit()

func _set_score(score_multiplier):
	pass
