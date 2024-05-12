extends Node2D

@onready var label = $Label

var max_scale = 1.0
var start_scale = 0.8
var settle_scale = 0.8
var time_to_max = 0.05
var time_to_settle = 0.05
var time_to_kill = 0.15

var time = 0
var growth_per_second : Vector2
var shrink_per_second : Vector2
var kill_after : float

func init(text : String):
	label.text = text

func _ready():
	scale = Vector2(start_scale, start_scale)
	var g = (max_scale - start_scale) / time_to_max
	growth_per_second = Vector2(g, g)
	var s = (settle_scale - max_scale) / time_to_settle
	shrink_per_second = Vector2(s, s)

func _process(delta):
	if time > time_to_max + time_to_settle + time_to_kill:
		queue_free()
	elif time > time_to_max && time < time_to_max + time_to_settle:
		scale = scale + shrink_per_second * delta
	elif time < time_to_max:
		scale = scale + growth_per_second * delta

	time = time + delta
