extends Node2D

# time in milliseconds before the scene is killed
@export var max_time = 5.0
@export var parent_game : Node2D = null
var score_set = false
# setting this to non-zero in case _process can run before _ready
var time : float = 1.0

func _ready():
	time = max_time

func _process(delta):
	time -= delta
	if parent_game != null:
		parent_game.update_time(time)
	if time <= 0.0:
		set_score(0)
		if parent_game == null:
			get_tree().quit()

func get_max_time():
	return max_time

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
