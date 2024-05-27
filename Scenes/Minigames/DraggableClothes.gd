extends Node2D

@export var pin_target_area : ReferenceRect
@export var placement_offset : Vector2
var selected = false
var placed = false
var mouse_offset : Vector2
var original_spot : Vector2

func _ready():
	original_spot = position

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if !placed && Input.is_action_just_pressed("click"):
		CursorCont.set_cursor(CursorCont.CursorType.fist)
		mouse_offset = position - get_global_mouse_position()
		selected = true
		get_parent().dragging = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position() + mouse_offset, 25 * delta)

func _input(event):
	if event is InputEventMouseButton and selected:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			get_parent().dragging = false
			var within_target = pin_target_area.get_rect().has_point(position)
			if within_target:
				position = pin_target_area.position + placement_offset
				placed = true
			else:
				position = original_spot
			CursorCont.set_cursor(CursorCont.CursorType.hand)
