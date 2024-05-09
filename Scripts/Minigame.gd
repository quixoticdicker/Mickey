extends Node2D

class_name Minigame

@export var max_time : float = 5.0
@export var mouse_visible : bool = true
@export var mouse_cursor : CursorCont.CursorType = CursorCont.CursorType.pointer
@export var has_info: bool = false

var parent_game : Node2D = null
var score_set = false
var time : float = 1.0

func _ready():
	time = max_time
	CursorCont.set_cursor(mouse_cursor)
	CursorCont.set_cursor_visibility(mouse_visible)

func _process(delta):
	time -= delta
	if parent_game != null:
		parent_game.update_time(time)
	if time <= 0.0:
		_set_score(0.0)
		if parent_game == null:
			get_tree().quit()

func _calculate_score(score_multiplier : float, time_mult : float = 1.0) -> float:
	return 0

func _set_score(score_multiplier : float) -> void:
	if not score_set:
		score_set = true
		
		if parent_game != null:
			var time_mult = time / max_time
			var score = _calculate_score(score_multiplier, time_mult)
			parent_game.add_score(score)

func _get_info() -> String:
	return "Unspecified info text"

func set_parent(parent : Node2D) -> void:
	parent_game = parent

func get_max_time() -> float:
	return max_time
