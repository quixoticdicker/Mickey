extends Minigame

func _on_correct_button_pressed():
	_set_score(1.0)

func _on_wrong_button_pressed():
	_set_score(0.0)

func _calculate_score(score_mult : float, time_mult : float = 1.0) -> float:
	return 100 * score_mult * time_mult
