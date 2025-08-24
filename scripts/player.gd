extends CharacterBody3D

@export var movement_speed := 8.0
@export var jump_force := 5.0
@export var gravity := 10.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta: float) -> void:
	var movement_direction = Vector3.ZERO
	
	if Input.is_action_pressed("move_forward"):
		movement_direction.z -= 1
	if Input.is_action_pressed("move_backward"):
		movement_direction.z += 1
	if Input.is_action_pressed("move_left"):
		movement_direction.x -= 1
	if Input.is_action_pressed("move_right"):
		movement_direction.x += 1
	if Input.is_action_pressed("set_mouse_free"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if is_on_floor():
		velocity.y = 0
		if Input.is_action_pressed("jump"):
			velocity.y = jump_force
	else:
		velocity.y -= gravity * delta
	
	if movement_direction != Vector3.ZERO:
		movement_direction = movement_direction.normalized()
		velocity.z = movement_direction.z * movement_speed
		velocity.x = movement_direction.x * movement_speed
	else:
		velocity.z = 0
		velocity.x = 0
	move_and_slide()
	
func _input(event: InputEvent) -> void:
	pass
	
	
