extends Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
