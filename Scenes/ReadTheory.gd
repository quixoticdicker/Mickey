extends Node2D

# time in seconds before the scene is killed
@export var max_time = 7.0
@export var parent_game : Node2D = null
var score_set = false
var time : float = 1.0

func _ready():
	time = max_time
	var file = "res://Scripts/quotations.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		var quotation_to_use = json_as_dict["quotes"].pick_random()
		$Quotation.add_text("\"%s\"\n\t- %s" % [quotation_to_use["body"], quotation_to_use["speaker"]])
	
	CursorCont.hide_cursor()

func _process(delta):
	time -= delta
	if parent_game != null:
		parent_game.update_time(time)
	if time <= 0.0:
		set_score()
		if parent_game == null:
			get_tree().quit()

func _draw():
	draw_rect(Rect2(0, 0, 1024, 768), Color.BLACK)

func get_max_time():
	return max_time

func set_parent(game_runner):
	parent_game = game_runner

func set_score():
	if not score_set:
		CursorCont.show_cursor()
		score_set = true
		
		if parent_game != null:
			parent_game.add_score(100)
