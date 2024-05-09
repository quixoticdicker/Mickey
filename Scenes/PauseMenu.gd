extends Control

@onready var game_runner = $"../"

func _on_quit_pressed():
	get_tree().quit()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/MainMenu.tscn")

func _on_resume_pressed():
	game_runner.pause_game()
