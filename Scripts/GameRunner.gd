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
var swap_game : bool = false

var minigames : Array[PackedScene] = [
	preload("res://Scenes/Minigames/PinTheTail.tscn"),
	preload("res://Scenes/Minigames/PunchNazis.tscn"),
	preload("res://Scenes/Minigames/ReadTheory.tscn"),
	preload("res://Scenes/Minigames/Interogation.tscn"),
	# heat exaustion scene is a wip
	#preload("res://Scenes/Minigames/HeatExaustion.tscn"),
	preload("res://Scenes/Minigames/EnergyMeter.tscn"),
	preload("res://Scenes/Minigames/PunchWarCriminals1.tscn"),
	preload("res://Scenes/Minigames/Cityscape.tscn"),
	preload("res://Scenes/Minigames/DressForProtest.tscn")
]
var last_played : PackedScene
var recently_played : Array[PackedScene] = []

@onready var strike_font : Font = load("res://Assets/Fonts/Homemade_Apple/HomemadeApple-Regular.ttf")
var strike_offset = Vector2(-10, 18) # the offset from the circle (strike position) to draw the actual strike

enum MenuState {none, pause, info}
var menu_state : MenuState = MenuState.none

func _draw():
	# regarding strikes
	var strike_zone = 256
	var step_size = strike_zone / (num_strikes - 1)
	for i in num_strikes:
		var strike_position = Vector2(512 - (strike_zone / 2) + (i * step_size), 768 - 64)
		draw_circle(strike_position, 16, Color.DARK_GRAY)
		draw_arc(strike_position, 16, 0, 360, 360, Color.LIGHT_GRAY)
		if i < strike_count:
			draw_string(strike_font, strike_position + strike_offset, '/', HORIZONTAL_ALIGNMENT_CENTER, -1, 40, Color.FIREBRICK, 3, 0, TextServer.ORIENTATION_HORIZONTAL)

func _ready():
	score_label = $Score
	update_score()
	swapper.call()

var swapper = func swap_minigame():
	if current_game != null:
		current_game.queue_free()

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

func _process(_delta):
	if Input.is_action_just_pressed("pause"):
		pause_game()

	if swap_game:
		swap_game = false
		SceneTransition.transition_func(swapper)

func pause_game():
	if menu_state == MenuState.pause:
		menu_state = MenuState.none
		pause_menu.hide()
		Engine.time_scale = 1
		CursorCont.restore_cursor_settings()
		current_game._enable_buttons()
	elif menu_state == MenuState.none:
		menu_state = MenuState.pause
		pause_menu.show()
		current_game._disable_buttons()
		CursorCont.save_cursor_settings()
		CursorCont.show_cursor()
		CursorCont.set_cursor(CursorCont.CursorType.pointer)
		Engine.time_scale = 0

func show_info():
	if menu_state == MenuState.info:
		menu_state = MenuState.none
		info_menu.hide()
		Engine.time_scale = 1
	elif menu_state == MenuState.none:
		menu_state = MenuState.info
		info_menu.set_text(current_game._get_info())
		info_menu.show()
		Engine.time_scale = 0

func update_time(new_time):
	$Timer.value = 100.0 * (1 - (new_time / max_time))

func update_score():
	score_label.text = ScoreTrack.score_to_string(score)

func add_score(to_add):
	if to_add <= 0:
		strike_count = strike_count + 1
		queue_redraw()
		print("%d strike(s)" % strike_count)

	score = score + to_add
	update_score()

	if strike_count >= num_strikes:
		ScoreTrack.score = score
		SceneTransition.change_scene_to_file("res://Scenes/GameOver.tscn")
	else:
		# we only swap game if it isn't game over
		swap_game = true

# This button controlls the info menu
func _on_button_pressed():
	show_info()

func _on_button_mouse_entered():
	CursorCont.save_cursor_settings()
	CursorCont.set_cursor(CursorCont.CursorType.pointer)
	CursorCont.set_cursor_visibility(true)

func _on_button_mouse_exited():
	CursorCont.restore_cursor_settings()
