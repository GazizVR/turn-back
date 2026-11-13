extends CharacterBody3D

const MOUSE_SENS = 0.001
@onready var cam = $CamPivot

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_flashlight") and !$FlashlightAudio.playing:
		$FlashlightAudio.playing = true
		$CamPivot/SpotLight3D.visible = !$CamPivot/SpotLight3D.visible
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x*MOUSE_SENS)
		var angle_x = -event.relative.y*MOUSE_SENS
		var rotation_x = cam.rotation.x + angle_x
		rotation_x = clamp(rotation_x,-1.5,1.5)
		cam.rotation.x = rotation_x

const SPEED = 1.25
const SPRINT_SPEED = 2.25
@onready var footsteps_player = $FootstepsStreamPlayer

var footsteps_sounds: Array[AudioStream] = [
	preload("res://assets/sounds/footsteps.ogg"),
	preload("res://assets/sounds/running.ogg")
]

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = SPEED
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
		if footsteps_player.stream != footsteps_sounds[1]:
			footsteps_player.stream = footsteps_sounds[1]
	else:
		if footsteps_player.stream != footsteps_sounds[0]:
			footsteps_player.stream = footsteps_sounds[0]
	if direction:
		if !footsteps_player.playing:
			footsteps_player.playing = true
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		footsteps_player.playing = false
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)
	
	move_and_slide()
