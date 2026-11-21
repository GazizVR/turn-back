extends RigidBody3D

var can_open = false
var is_opened = false
var is_closing = false

var SPEED = 10.0

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact") and !is_opened and can_open:
		apply_central_impulse(Vector3.BACK * SPEED)

func _integrate_forces(state: PhysicsDirectBodyState3D) -> void:
	if !is_opened:
		if rotation_degrees.z >= 90:
			is_opened = true
			state.angular_velocity = Vector3.ZERO
			state.linear_velocity = Vector3.ZERO
	if is_closing:
		if rotation_degrees.z < 0.1:
			is_closing = false
			state.angular_velocity = Vector3.ZERO
			state.linear_velocity = Vector3.ZERO

@onready var player: CharacterBody3D = $"../../../../Player"

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		if !is_closing:
			is_closing = true
			apply_central_impulse(Vector3.FORWARD * SPEED)

func _on_interact_area_3d_body_entered(body: Node3D) -> void:
	if body == player:
		can_open = true

func _on_interact_area_3d_body_exited(body: Node3D) -> void:
	if body == player:
		can_open = false
