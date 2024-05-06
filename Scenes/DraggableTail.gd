extends Node2D

@export var pin_target : Node2D
@export var minigame : Node2D
var selected = false

var fist_cursor = load("res://Assets/Cursor/Fist.png")

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("click"):
		Input.set_custom_mouse_cursor(fist_cursor, Input.CURSOR_ARROW, Vector2(63, 32))
		selected = true

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)

func _input(event):
	if event is InputEventMouseButton and selected:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			var target_distance = global_position.distance_to(pin_target.global_position)
			var score = 1/(target_distance + 1)
			minigame.set_score(score)
