extends Control

const GAME_SCENE := "res://scenes/game.tscn"

@onready var start_button: Button = %StartButton
@onready var quit_button: Button = %QuitButton
@onready var hint_label: Label = %Hint


func _ready() -> void:
	# Coming back from the pause menu must never leave the tree paused.
	get_tree().paused = false
	# Browsers can't close the tab, and Apple rejects iOS apps with a Quit
	# button (users leave with the home gesture instead).
	if OS.has_feature("web") or OS.has_feature("mobile"):
		quit_button.hide()
	if DisplayServer.is_touchscreen_available():
		hint_label.text = "Use the on-screen buttons to move, jump and pause"
	start_button.grab_focus()


func _on_start_button_pressed() -> void:
	get_tree().change_scene_to_file(GAME_SCENE)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
