extends Node2D

@export var pin_target : ReferenceRect
@export var minigame : Minigame
var selected = false
var mouse_offset : Vector2

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		CursorCont.set_cursor(CursorCont.CursorType.fist)
		mouse_offset = position - get_global_mouse_position()
		selected = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position() + mouse_offset, 25 * delta)

func _input(event):
	if event is InputEventMouseButton and selected:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var within_target = pin_target.get_rect().has_point(position)
			if within_target:
				minigame._set_score(1.0)
			else:
				minigame._set_score(0.0)
