extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_HEALTH = 2
const DEATH_TIME = 2.0  # Time before scene reload
const DAMAGE_TIME = 1.0
var health
var is_dead = false
var is_taking_damage = false

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
# Animation state enum for type safety
const AnimationState := {
	"IDLE": "idle", 	
	"RUN": "run", 
	"JUMP": "jump", 
	"DEATH": "death", 
	"DAMAGE": "damage"
	}
	
enum PlayerState {
	NORMAL,
	DEATH,
	DAMAGE
}
var player_state : PlayerState

func _ready() -> void:
	health = MAX_HEALTH
	player_state = PlayerState.NORMAL
	print(health)

func _physics_process(delta: float) -> void:
	if is_dead or is_taking_damage:
		move_and_slide()
		return
		
	apply_gravity(delta)
	handle_input()
	play_animation()
	move_and_slide()

func apply_gravity(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_input() -> void:
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction: -1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	# Flip the Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	# Horizontal movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func play_animation() -> void:
	var new_state: String
	
	# Play animations
	if not is_on_floor():
		new_state = AnimationState.JUMP
	elif velocity.x == 0:
		new_state = AnimationState.IDLE
	else:
		new_state = AnimationState.RUN
	
	animated_sprite.play(new_state)

func take_damage(dmg: int) -> void:
	health -= dmg
	print(health)
	if health <= 0 and is_dead == false:
		die()
	else:
		print("take damage")
		is_taking_damage = true
		animated_sprite.play("damage")
		get_tree().create_timer(DAMAGE_TIME).timeout.connect(_on_damage_timer_timeout)
		

func _on_damage_timer_timeout() -> void:
	print("damage taken")
	is_taking_damage = false
	
func die() -> void:
	if is_dead:
		return
	
	print("You died!")
	is_dead = true
	velocity.x = 0
	print("Playing death")
	animated_sprite.play("death")

	get_tree().create_timer(DEATH_TIME).timeout.connect(_on_death_timer_timeout)


func _on_death_timer_timeout() -> void:
	get_tree().reload_current_scene()
