extends Control

const GAME_SCENE := "res://scenes/game.tscn"

@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	# Coming back from the pause menu must never leave the tree paused.
	get_tree().paused = false
	# Quitting makes no sense in a browser build.
	if OS.has_feature("web"):
		quit_button.hide()
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
