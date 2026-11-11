extends Node3D

@onready var player = $AudioStreamPlayer3D

func _input(event: InputEvent) -> void:
	if event.is_action("play_sound") and not player.playing:
		player.play()

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
