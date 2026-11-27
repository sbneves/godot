extends CanvasLayer
## Overlay that pauses the game. Runs with process_mode = ALWAYS so it keeps
## receiving input while the rest of the tree is paused.

const MAIN_MENU_SCENE := "res://scenes/main_menu.tscn"

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton


func _ready() -> void:
	hide()
	# Browsers can't close the tab, and Apple rejects iOS apps with a Quit
	# button (users leave with the home gesture instead).
	if OS.has_feature("web") or OS.has_feature("mobile"):
		quit_button.hide()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		set_paused(not get_tree().paused)
		get_viewport().set_input_as_handled()


func set_paused(value: bool) -> void:
	get_tree().paused = value
	visible = value
	if value:
		resume_button.grab_focus()


func _on_resume_button_pressed() -> void:
	set_paused(false)


func _on_restart_button_pressed() -> void:
	set_paused(false)
	get_tree().reload_current_scene()


func _on_main_menu_button_pressed() -> void:
	set_paused(false)
	get_tree().change_scene_to_file(MAIN_MENU_SCENE)


func _on_quit_button_pressed() -> void:
	get_tree().quit()
