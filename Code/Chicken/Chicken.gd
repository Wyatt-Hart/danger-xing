extends Area3D
class_name Chicken

@onready var mesh: Node3D = $Mesh



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_collision)

func on_collision(area: Area3D):
	if area is Goal:
		print("Goal!!!!")

	# ToDo: Add more collision types
	#if area is Car:
	#	print("Dead :(")


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("move_left"):
		position.x += 1
		mesh.rotation_degrees.y = 90.0;
	elif Input.is_action_just_pressed("move_right"):
		position.x -= 1
		mesh.rotation_degrees.y = -90.0;
	elif Input.is_action_just_pressed("move_forward"):
		position.z += 1
		mesh.rotation_degrees.y = 0;
	elif Input.is_action_just_pressed("move_backward"):
		position.z -= 1
		mesh.rotation_degrees.y = 180;
	
