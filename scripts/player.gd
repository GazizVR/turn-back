extends CharacterBody3D

const MOUSE_SENS = 0.001
@onready var cam = $CamPivot
@onready var footsteps_player = $FootstepsStreamPlayer

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("toggle_flashlight") and !$FlashlightAudio.playing:
		$FlashlightAudio.playing = true
		$CamPivot/SpotLight3D.visible = !$CamPivot/SpotLight3D.visible
	if is_on_floor():
		if event.is_action_pressed("move_forward"):
			footsteps_player.playing = true
		if event.is_action_released("move_forward"):
			footsteps_player.playing = false
	else:
		footsteps_player.playing = false
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x*MOUSE_SENS)
		var angle_x = -event.relative.y*MOUSE_SENS
		var rotation_x = cam.rotation.x + angle_x
		rotation_x = clamp(rotation_x,-1,1)
		cam.rotation.x = rotation_x

const SPEED = 3.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
