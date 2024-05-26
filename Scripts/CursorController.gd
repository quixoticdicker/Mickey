extends Node

class_name CursorController

var fist_cursor = load("res://Assets/Cursor/Fist_half.png")
var pointer_cursor = load("res://Assets/Cursor/Pointer_half.png")
var hand_cursor = load("res://Assets/Cursor/Open_half.png")
var lens_cursor = load("res://Assets/Cursor/Lens_raw.png")
var last_cursor = CursorType.pointer
var last_visibility = Input.MOUSE_MODE_VISIBLE
var saved_cursor : CursorType
var saved_visibility : Input.MouseMode

enum CursorType {fist, pointer, hand, lens}

func set_cursor(cursor_type : CursorType):
	last_cursor = cursor_type
	match cursor_type:
		CursorType.fist:
			Input.set_custom_mouse_cursor(fist_cursor, Input.CURSOR_ARROW, Vector2(32, 16))
		CursorType.pointer:
			Input.set_custom_mouse_cursor(pointer_cursor, Input.CURSOR_ARROW, Vector2(24, 0))
		CursorType.hand:
			Input.set_custom_mouse_cursor(hand_cursor, Input.CURSOR_ARROW, Vector2(50, 43))
		CursorType.lens:
			Input.set_custom_mouse_cursor(lens_cursor, Input.CURSOR_ARROW, Vector2(82, 77))

func set_cursor_visibility(visible : bool):
	if visible:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		last_visibility = Input.MOUSE_MODE_VISIBLE
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
		last_visibility = Input.MOUSE_MODE_HIDDEN

func hide_cursor():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	last_visibility = Input.MOUSE_MODE_HIDDEN

func show_cursor():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	last_visibility = Input.MOUSE_MODE_VISIBLE

func save_cursor_settings():
	saved_cursor = last_cursor
	saved_visibility = last_visibility

func restore_cursor_settings():
	set_cursor(saved_cursor)
	Input.set_mouse_mode(saved_visibility)
	last_visibility = saved_visibility
