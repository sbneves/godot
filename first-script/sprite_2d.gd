extends Sprite2D

var speed = 400
var angular_speed = PI

func _init():
	print("Hello world!")

func _process(delta):
	
	var direction = 0
	if Input.is_action_pressed("ui_left"):
		direction = -1
	if Input.is_action_pressed("ui_right"):
		direction = 1
	rotation += angular_speed * delta * direction
	
	var movement = 0
	if Input.is_action_pressed("ui_up"):
		movement = -1
	if Input.is_action_pressed("ui_down"):
		movement = 1
	move_local_y(speed * delta * movement)
	
	#var velocity = Vector2.UP.rotated(rotation) * speed
	#position += velocity * delta


func _on_button_pressed() -> void:
	pass # Replace with function body.
