extends CanvasLayer

var is_paused = false

func toggle_paused():
	is_paused = !is_paused
	get_tree().paused = is_paused
	pause_menu.visible = is_paused
	if is_paused:
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else: 
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


@onready var pause_menu = $PauseMenu

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		toggle_paused()
func _on_yes_btn_pressed() -> void:
	get_tree().quit()

func _on_no_btn_pressed() -> void:
	toggle_paused()
