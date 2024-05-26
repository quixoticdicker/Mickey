extends Node2D

@export var duration = 3

var time = 3

func _ready():
	time = duration

func _process(delta):
	time -= delta
	if time <= 0.0:
		SceneTransition.change_scene_to_file("res://Scenes/MainMenu.tscn", "dissolve")
