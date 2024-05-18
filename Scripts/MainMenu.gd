extends Control

# Called when the node enters the scene tree for the first time.
func _ready():
	var play_button = $Buttons/NewGameButton
	play_button.pressed.connect(on_play_button_pressed)
	
	var exit_button = $Buttons/QuitButton
	exit_button.pressed.connect(on_exit_button_pressed)
	
	CursorCont.set_cursor(CursorCont.CursorType.pointer)

func on_play_button_pressed():
	SceneTransition.change_scene_to_file("res://Scenes/GameRunner.tscn")

func on_exit_button_pressed():
	get_tree().quit()
