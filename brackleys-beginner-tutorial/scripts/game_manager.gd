extends Node

var score = 0
@onready var score_label: Label = $ScoreLabel
@onready var jump_hint: Label = $"../Labels/Label"

func _ready() -> void:
	if DisplayServer.is_touchscreen_available():
		jump_hint.text = "Tap the jump button"

func add_point():
	score += 1
	score_label.text = "You collected " + str(score) + " coins."
