extends CharacterBody3D

@export var movement_speed := 8.0
@export var jump_force := 5.0
@export var gravity := 10.0

@export var mouse_sense := 0.005
var pitch := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta: float) -> void: 
	var input_vec: Vector2 = Input.get_vector("move_left", "move_right", "move_backward", "move_forward")

	var cam_basis = $"Body/Head/Camera3D".global_transform.basis
	var forward : Vector3 = -cam_basis.z 
	forward.y = 0 
	forward = forward.normalized()

	var right : Vector3 = cam_basis.x 
	right.y = 0 
	right = right.normalized()
	var direction = right * input_vec.x + forward * input_vec.y
	
	if Input.is_action_pressed("set_mouse_free"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force
	else:
		velocity.y -= gravity * delta
	
	if direction != Vector3.ZERO:
		direction = direction.normalized()
		velocity.z = direction.z * movement_speed
		velocity.x = direction.x * movement_speed
	else:	
		velocity.z = 0
		velocity.x = 0
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sense)
		
		pitch -= event.relative.y * mouse_sense
		pitch = clamp(pitch, deg_to_rad(-80), deg_to_rad(80))
		
		$"Body/Head".rotation.x = pitch
		
