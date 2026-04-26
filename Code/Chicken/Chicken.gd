extends Node3D
class_name Chicken


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		position.x += 1
	elif Input.is_action_just_pressed("move_right"):
		position.x -= 1
	elif Input.is_action_just_pressed("move_forward"):
		position.z += 1
	elif Input.is_action_just_pressed("move_backward"):
		position.z -= 1
	
