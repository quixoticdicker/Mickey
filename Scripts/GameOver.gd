extends Node2D

@onready var score_label = $Control/ScoreLabel

func _ready():
	score_label.text = ScoreTrack.score_to_string(ScoreTrack.score)
	CursorCont.set_cursor(CursorCont.CursorType.pointer)

func _on_replay_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/GameRunner.tscn")


func _on_main_menu_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")
