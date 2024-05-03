extends Node2D

# time in milliseconds before the scene is killed
@export var time = 5.0
@export var parent_game : Node2D = null
var score_set = false
var total_nazi_count = 2.0
var punched_nazis = 0.0
var last_nazi_punched_at = time


func _process(delta):
	time -= delta
	if time <= 0.0:
		set_score()
		if parent_game == null:
			await get_tree().create_timer(1.0).timeout
			get_tree().quit()

func set_parent(game_runner):
	parent_game = game_runner

func set_score():
	if not score_set:
		score_set = true
		
		var time_mult = last_nazi_punched_at / 5.0
		var score_mult = punched_nazis / total_nazi_count
		var score = 100 * time_mult * score_mult
		print("Score: %d" % score)
		if parent_game != null:
			parent_game.add_score(score)


func punch_nazi():
	punched_nazis = punched_nazis + 1.0
	last_nazi_punched_at = time
	if punched_nazis >= total_nazi_count:
		set_score()
