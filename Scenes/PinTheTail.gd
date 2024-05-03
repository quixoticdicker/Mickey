extends Node2D

# time in milliseconds before the scene is killed
@export var time = 5.0
@export var parent_game : Node2D = null
var score_set = false

func _process(delta):
	time -= delta
	if time <= 0.0:
		set_score(0)
		if parent_game == null:
			get_tree().quit()

func set_parent(game_runner):
	parent_game = game_runner

func set_score(score_mult):
	if not score_set:
		score_set = true
		var time_mult = time / 5.0
		var score = 100 * time_mult * score_mult
		print("Score: %d" % score)
		
		if parent_game != null:
			parent_game.add_score(score)
