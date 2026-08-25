extends Area2D

@export var speed = 300
@export var initial_velocity = Vector2(1, 1)

var _velocity
var start_position

func _ready():
	_velocity = initial_velocity * speed
	start_position = position

func _physics_process(delta):
	position += _velocity * delta

func reset():
	position = start_position
	_velocity = initial_velocity * speed
