extends Node3D

func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
	if Input.is_action_pressed("reset"):
		get_tree().reload_current_scene()
