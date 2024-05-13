extends Minigame

func _ready():
	time = max_time
	var file = "res://Scripts/quotations.json"
	var json_as_text = FileAccess.get_file_as_string(file)
	var json_as_dict = JSON.parse_string(json_as_text)
	if json_as_dict:
		var quotation_to_use = json_as_dict["quotes"].pick_random()
		$Quotation.text = "\"%s\"\n\t- %s" % [quotation_to_use["body"], quotation_to_use["speaker"]]
	
	CursorCont.hide_cursor()

func _draw():
	draw_rect(Rect2(0, 0, 1024, 768), Color.BLACK)

func _set_score(score_mult : float) -> void:
	if not score_set:
		CursorCont.show_cursor()
		score_set = true
		
		if parent_game != null:
			parent_game.add_score(100)
