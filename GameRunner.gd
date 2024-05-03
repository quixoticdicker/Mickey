extends Node2D

var score = 0
var current_game : Node2D
var score_label : Label

var minigames = [
	preload("res://Scenes/PinTheTail.tscn"),
	preload("res://Scenes/PunchNazis.tscn"),
	preload("res://Scenes/ReadTheory.tscn")
]
var last_played : PackedScene
var recently_played = []

func _ready():
	score_label = $Score
	update_score()

func _process(_delta):
	if current_game == null:
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
		add_child(current_game)
		current_game.set_parent(self)

func update_score():
	score_label.text = str(floor(score))

func add_score(to_add):
	score = score + to_add
	update_score()
	current_game.queue_free()
