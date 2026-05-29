extends Area3D
class_name Chicken

@onready var mesh: Node3D = $Mesh
@onready var lives_ui: Label = $UI/LivesUI
@onready var gameover_ui: PanelContainer = $GameOverContainer

var lives: int = 8


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_collision)
	lives_ui.text = "Lives: " + str(lives)
	gameover_ui.visible = false

func on_collision(area: Area3D):
	if area is Goal:
		respawn()
		print("Goal!!!!")

	if area is Car:
		killed()

func killed():
	if lives <= 0:
		lives_ui.visible = false
		gameover_ui.visible = true
		pass
	respawn()
	lives -= 1
	lives_ui.text = "Lives: " + str(lives)

func respawn():
	position = Vector3.ZERO
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
	
