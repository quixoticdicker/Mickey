extends Node2D

@export var pin_target : Node2D
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
			var target_distance = global_position.distance_to(pin_target.global_position)
			var score = clampf((100 - target_distance) / 100, 0.0, 1.0)
			minigame._set_score(score)
