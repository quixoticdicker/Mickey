extends Node

class_name ScoreTracker

# used for passing score between GameRunner and GameOver scenes
var score : float = 0.0

func score_to_string(score):
	var int_score : int = floor(score)
	var str_score = ""
	while int_score >= 1000:
		var lowest = int_score % 1000
		str_score = "," + str(lowest).pad_zeros(3) + str_score
		int_score = floor(int_score / 1000)
	str_score = str(int_score) + str_score
	return str_score
