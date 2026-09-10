extends AnimatableBody2D

var speed = 50
var axis = 'x'
var distance = 100
var pause = 1
var direction = 1
var total_movement = 0
var travel_time = 2

func _ready():
	var start = position
	var end = start + Vector2(distance, 0)

	var tween = create_tween().set_loops()

	tween.tween_property(self, "position", end, travel_time)
	tween.tween_interval(pause)

	tween.tween_property(self, "position", start, travel_time)
	tween.tween_interval(pause)
