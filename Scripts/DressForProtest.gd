extends Minigame

var wearing_bandana = false
var wearing_black_shirt = false
var wearing_boots = false
var wearing_glasses = false
var wearing_n95 = false
var wearing_orange_shirt = false
var wearing_pants = false
var wearing_hat = false
var wearing_sandals = false

var dragging = false

func _calculate_score(score_mult : float, time_mult : float = 1.0) -> float:
	return 100 * score_mult * time_mult

func _on_button_pressed():
	var score_mult = 0
	if wearing_bandana:
		score_mult += 0.2
	if wearing_black_shirt:
		score_mult += 0.2
	if wearing_glasses:
		score_mult += 0.2
	if wearing_n95:
		score_mult += 0.2
	if wearing_orange_shirt:
		score_mult -= 0.3
	if wearing_pants:
		score_mult += 0.2
	if wearing_hat:
		pass
		# no effect on score
	if wearing_sandals:
		score_mult -= 0.4

	score_mult = clamp(score_mult, 0.0, 1.0)
	_set_score(score_mult)

func _on_button_mouse_entered():
	if !dragging:
		CursorCont.set_cursor(CursorCont.CursorType.pointer)

func _on_button_mouse_exited():
	if !dragging:
		CursorCont.set_cursor(CursorCont.CursorType.hand)
