extends Area2D

@export var speed = 500
@export var direction = 1

var _position

func _ready():
	_position = position
	connect("input_event", _on_input)

func _physics_process(delta):
	var input_dir = 0
	if Input.is_action_pressed("ui_up"):
		input_dir -= 1
	if Input.is_action_pressed("ui_down"):
		input_dir += 1
	
	position = _position + Vector2(0, input_dir) * speed * delta

func _on_input(viewport, event, shape_idx, local_position):
	pass
