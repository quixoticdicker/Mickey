extends Node2D

@export var punched_face : Sprite2D

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click") and not punched_face.visible:
		punched_face.visible = true
		get_parent().punch()
