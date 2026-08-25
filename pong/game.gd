extends Node2D

const SCORE_TO_WIN = 5

var player_score = 0
var computer_score = 0

func _ready():
	var label = get_node("Label")
	var label_2 = get_node("Label_2")
	if label and label_2:
		label.text = "Press Space to Start"
		label_2.text = "Player: 0  Computer: 0"
	
	# Connect ball reset to space press
	$Ball.connect("area_entered", self, "_on_ball_scored")

func _physics_process(delta):
	pass

func _on_ball_scored(body):
	player_score += 1
	update_score()
	
	if player_score >= SCORE_TO_WIN:
		var label = get_node("Label")
		if label:
			label.text = "You Win!"
	else:
		var label = get_node("Label")
		if label:
			label.text = "Round Over - Press Space to Continue"
	
	$Ball.reset()

func update_score():
	var label_2 = get_node("Label_2")
	if label_2:
		label_2.text = "Player: %d  Computer: %d" % [player_score, computer_score]
