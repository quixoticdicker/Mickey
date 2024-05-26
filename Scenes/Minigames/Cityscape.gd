extends Minigame

func _input(event):
	if event is InputEventMouseMotion:
		#$Lens_temp.position = event.position
		$PointLight2D.position = event.position
		$CityscapeZoomed.position = event.position * -3

func _calculate_score(score_mult : float, time_mult : float = 1.0) -> float:
	return 100 * score_mult * time_mult

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		_set_score(1.0)
