extends Minigame

var total_count = 7.0
var punched = 0.0
var last_punched_at = time

func _set_score(score_mult : float) -> void:
	if not score_set:
		score_set = true
		
		var time_mult = last_punched_at / 5.0
		score_mult = punched / total_count
		var score = 100 * time_mult * score_mult
		if parent_game != null:
			parent_game.add_score(score)

var pow = preload("res://Scenes/Pow.tscn")

func punch():
	$PunchSound.play()
	$OofSound.play()
	var pow_scene = pow.instantiate()
	add_child(pow_scene)
	pow_scene.global_position = get_viewport_rect().size / 2
	punched = punched + 1.0
	last_punched_at = time
	if punched >= total_count:
		_set_score(1.0)
