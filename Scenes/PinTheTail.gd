extends Minigame

func _calculate_score(score_mult : float, time_mult : float = 1.0) -> float:
	return 100 * score_mult * time_mult
