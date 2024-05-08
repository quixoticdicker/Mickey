extends Node2D

# time in seconds before the scene is killed
@export var max_time = 4.0
@export var parent_game : Node2D = null
var score_set = false
var time : float = 1.0

func _on_correct_button_pressed():
	set_score(true)

func _on_wrong_button_pressed():
	set_score(false)

func _ready():
	time = max_time
	
	CursorCont.set_cursor(CursorCont.CursorType.pointer)

func _process(delta):
	time -= delta
	if parent_game != null:
		parent_game.update_time(time)
	if time <= 0.0:
		set_score(set_score(false))
		if parent_game == null:
			get_tree().quit()

func get_max_time():
	return max_time

func set_parent(game_runner):
	parent_game = game_runner

func set_score(was_correct_button):
	if not score_set:
		score_set = true
		
		if parent_game != null:
			if was_correct_button:
				var time_mult = time / max_time
				parent_game.add_score(100 * time_mult)
			else:
				parent_game.add_score(0)
