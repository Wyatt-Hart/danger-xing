extends Area3D
class_name Chicken

@onready var mesh: Node3D = $Mesh
@onready var lives_ui: Label = $UI/LivesUI
@onready var gameover_ui: PanelContainer = $GameOverContainer

var lives: int = 8

# Position
var spawn_point: Vector3
var from: Vector3
var to: Vector3
var weight: float = 1.0
var lerp_speed: float = 12.0 # m/s
var isLerping: bool = false


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
	respawn()
	if lives <= 0:
		lives_ui.visible = false
		gameover_ui.visible = true
		pass
	lives -= 1
	lives_ui.text = "Lives: " + str(lives)

func respawn():
	weight = 1.0
	position = spawn_point
	mesh.rotation_degrees.y = 0


func _process(delta: float) -> void:
	if lives < 0:
		return
	
	# If weight < 1.0, then we are lerping/moving
	if isLerping == false:
		if Input.is_action_just_pressed("move_left"):
			move(Vector3.LEFT, 90.0)
	
		elif Input.is_action_just_pressed("move_right"):
			move(Vector3.RIGHT, -90.0)
	
		elif Input.is_action_just_pressed("move_forward"):
			move(Vector3.FORWARD, 0.0)

		elif Input.is_action_just_pressed("move_backward"):
			move(Vector3.BACK, 180.0)
	
	# Update position
	if weight < 1.0:
		isLerping = true
		weight += lerp_speed * delta
	else:
		isLerping = false
		weight = 1.0
		from = to

	position = lerp(from, to, weight)

func move(direction: Vector3, rotation: float):
	to = from - direction
	weight = 0.0
	mesh.rotation_degrees.y = rotation
