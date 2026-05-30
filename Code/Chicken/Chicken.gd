extends Area3D
class_name Chicken

@onready var mesh: Node3D = $Mesh
@onready var lives_ui: Label = $UI/LivesUI
@onready var gameover_ui: PanelContainer = $GameOverContainer

var lives: int = 8
var spawn_point: Vector3
var from: Vector3
var to: Vector3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_collision)
	lives_ui.text = "Lives: " + str(lives)
	gameover_ui.visible = false
	spawn_point = position
	from = spawn_point
	to = spawn_point

func on_collision(area: Area3D):
	if area is Goal:
		respawn()
		print("Goal!!!!")

	if area is Car:
		destroy()

	if area is Vessel:
		print("Riding vessel ...")
	elif area is River:
		destroy()

func destroy():
	if lives <= 0:
		lives_ui.visible = false
		gameover_ui.visible = true
		pass
	respawn()
	lives -= 1
	lives_ui.text = "Lives: " + str(lives)

func respawn():
	position = spawn_point
	mesh.rotation_degrees.y = 0


func _process(delta: float) -> void:
	if lives < 0:
		return
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
	
