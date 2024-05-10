extends Node2D

var score = 0
var current_game : Minigame
var score_label : Label
@export var num_strikes : int = 3
@onready var pause_menu = $PauseMenu
var paused = false
var pausable = true
@onready var info_menu = $InfoMenu
var shown_info = false

var time : float = 0.0
var max_time : float = 1.0
var strike_count : int = 0
var strike_boxes = []

var minigames : Array[PackedScene] = [
	preload("res://Scenes/PinTheTail.tscn"),
	preload("res://Scenes/PunchNazis.tscn"),
	preload("res://Scenes/ReadTheory.tscn"),
	preload("res://Scenes/Interogation.tscn"),
	preload("res://Scenes/HeatExaustion.tscn")
]
var last_played : PackedScene
var recently_played : Array[PackedScene] = []

func _draw():
	# regarding strikes
	var strike_zone = 256
	var step_size = strike_zone / (num_strikes - 1)
	for i in num_strikes:
		var strike_position = Vector2(512 - (strike_zone / 2) + (i * step_size), 768 - 64)
		draw_circle(strike_position, 16, Color.DARK_GRAY)
		draw_arc(strike_position, 16, 0, 360, 360, Color.LIGHT_GRAY)
		if i < strike_count:
			draw_line(strike_position + Vector2(-16, 16), strike_position + Vector2(16, -16), Color.DARK_RED, 4.0)

func _ready():
	score_label = $Score
	update_score()

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()

	if current_game == null:
		print("Creating game")
		# add a new minigame. This all insures that we don't play the same game twice
		if minigames.size() <= 0:
			minigames = recently_played
			recently_played = []
		var chosen_minigame = minigames.pick_random()
		minigames.erase(chosen_minigame)
		if last_played != null:
			recently_played.append(last_played)
		last_played = chosen_minigame
		current_game = chosen_minigame.instantiate()
		current_game.z_as_relative = false
		current_game.z_index = 0
		add_child(current_game)
		current_game.set_parent(self)
		max_time = current_game.get_max_time()
		$InfoButton.visible = current_game.has_info

func pause_game():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
		CursorCont.restore_cursor_settings()
	else:
		pause_menu.show()
		CursorCont.save_cursor_settings()
		CursorCont.show_cursor()
		CursorCont.set_cursor(CursorCont.CursorType.pointer)
		Engine.time_scale = 0
	
	paused = !paused

func show_info():
	if shown_info:
		info_menu.hide()
		Engine.time_scale = 1
	else:
		info_menu.show()
		Engine.time_scale = 0
	shown_info = !shown_info

func update_time(new_time):
	$Timer.value = 100.0 * (1 - (new_time / max_time))

func update_score():
	score_label.text = str(floor(score))

func add_score(to_add):
	if to_add <= 0:
		strike_count = strike_count + 1
		queue_redraw()
		print("%d strike(s)" % strike_count)

	score = score + to_add
	update_score()
	current_game.queue_free()

	if strike_count >= num_strikes:
		get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

# This button controlls the info menu
func _on_button_pressed():
	show_info()

func _on_button_mouse_entered():
	CursorCont.save_cursor_settings()
	CursorCont.set_cursor(CursorCont.CursorType.pointer)
	CursorCont.set_cursor_visibility(true)

func _on_button_mouse_exited():
	CursorCont.restore_cursor_settings()
