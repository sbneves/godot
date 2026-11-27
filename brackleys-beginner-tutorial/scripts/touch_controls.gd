extends CanvasLayer
## On-screen buttons for touch devices (iPhone/iPad). Each button presses the
## same input action the keyboard uses, so player.gd and pause_menu.gd need no
## changes. Buttons only show when a touchscreen is present.

const BUTTON_SIZE := 96.0
const SPACING := 24.0
const MIN_MARGIN := 24.0

@onready var left_button: TouchScreenButton = $Left
@onready var right_button: TouchScreenButton = $Right
@onready var jump_button: TouchScreenButton = $Jump
@onready var pause_button: TouchScreenButton = $Pause


func _ready() -> void:
	get_viewport().size_changed.connect(_layout)
	_layout()


func _process(_delta: float) -> void:
	# Hide the controls behind the pause menu.
	visible = not get_tree().paused


func _layout() -> void:
	var view_size := get_viewport().get_visible_rect().size
	var insets := _safe_area_insets(view_size)
	var left := insets.position.x + MIN_MARGIN
	var top := insets.position.y + MIN_MARGIN
	var right := view_size.x - insets.size.x - MIN_MARGIN
	var bottom := view_size.y - insets.size.y - MIN_MARGIN

	left_button.position = Vector2(left, bottom - BUTTON_SIZE)
	right_button.position = Vector2(left + BUTTON_SIZE + SPACING, bottom - BUTTON_SIZE)
	jump_button.position = Vector2(right - BUTTON_SIZE, bottom - BUTTON_SIZE)
	pause_button.position = Vector2(right - BUTTON_SIZE, top)


## Returns the notch / home-indicator insets in viewport units:
## position = left/top, size = right/bottom.
func _safe_area_insets(view_size: Vector2) -> Rect2:
	var screen_size := Vector2(DisplayServer.window_get_size())
	var safe := Rect2(DisplayServer.get_display_safe_area())
	if screen_size.x <= 0 or screen_size.y <= 0 or safe.size == Vector2.ZERO:
		return Rect2()
	# On desktop the safe area is the whole monitor, not the window; ignore it.
	if not OS.has_feature("mobile"):
		return Rect2()
	var scale := view_size / screen_size
	var top_left := safe.position * scale
	var bottom_right := (screen_size - safe.end) * scale
	return Rect2(top_left.max(Vector2.ZERO), bottom_right.max(Vector2.ZERO))
