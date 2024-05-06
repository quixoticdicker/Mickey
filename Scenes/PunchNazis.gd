extends Node2D

# time in milliseconds before the scene is killed
@export var max_time = 5.0
@export var parent_game : Node2D = null
var score_set = false
var total_nazi_count = 2.0
var punched_nazis = 0.0
var last_nazi_punched_at = time
var time : float = 1.0

var fist_cursor = load("res://Assets/Cursor/Fist.png")

func _ready():
	time = max_time
	Input.set_custom_mouse_cursor(fist_cursor, Input.CURSOR_ARROW, Vector2(63, 32))

func _process(delta):
	time -= delta
	if parent_game != null:
		parent_game.update_time(time)
	if time <= 0.0:
		set_score()
		if parent_game == null:
			await get_tree().create_timer(1.0).timeout
			get_tree().quit()

func get_max_time():
	return max_time

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
