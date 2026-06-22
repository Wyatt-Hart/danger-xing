extends Area3D
class_name Chicken

@onready var collider: CollisionShape3D = $CollisionShape3D
@onready var mesh: Node3D = $Mesh
@onready var lives_ui: Label = $UI/LivesUI
@onready var score_ui: Label = $UI/ScoreUI
@onready var gameover_ui: PanelContainer = $GameOverContainer

# Touch Controls
@onready var touch_controls: PanelContainer = $TouchControls
@onready var up_arrow_btn: Button = $TouchControls/VBoxContainer/HBoxContainer2/UpArrowBtn
@onready var left_arrow_btn: Button = $TouchControls/VBoxContainer/HBoxContainer/LeftArrowBtn
@onready var down_arrow_btn: Button = $TouchControls/VBoxContainer/HBoxContainer/DownArrowBtn
@onready var right_arrow_btn: Button = $TouchControls/VBoxContainer/HBoxContainer/RightArrowBtn

var main: Main
var lives: int = 8
var score: int = 0

# Position
var spawn_point: Vector3
var from: Vector3
var to: Vector3
var weight: float = 1.0
@export var lerp_speed: float = 12.0 # m/s
var is_lerping: bool = false
var riding_vessel: Vessel = null


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if !is_mobile_web():
		touch_controls.hide()
		get_tree().root.content_scale_factor = 2
	else:
		touch_controls.show()
	area_entered.connect(on_collision)
	up_arrow_btn.pressed.connect(move.bind(Vector3.FORWARD, 0.0))
	left_arrow_btn.pressed.connect(move.bind(Vector3.LEFT, 90.0))
	down_arrow_btn.pressed.connect(move.bind(Vector3.BACK, 180.0))
	right_arrow_btn.pressed.connect(move.bind(Vector3.RIGHT, -90.0))
	lives_ui.text = "Lives: " + str(lives)
	score_ui.text = "Score: " + str(score)
	gameover_ui.visible = false
	spawn_point = position
	from = spawn_point
	to = spawn_point
	main = get_parent().get_parent()

func on_collision(area: Area3D):
	if area is Goal:
		area.occupy()
		goal()
		print("Goal!!!!")

	if area is Car:
		print("RIP: Hit by car")
		destroy()

	if area is Vessel:
		riding_vessel = area
		print("Riding vessel ...")
	elif area is River and riding_vessel == null:
		print("RIP: Fell in river")
		destroy()

func destroy():
	respawn()
	if lives <= 0:
		lives_ui.visible = false
		#gameover_ui.visible = true
		main.game_over()
		pass
	update_lives(-1)

func update_lives(delta_lives: int):
	lives += delta_lives
	lives_ui.text = "Lives: " + str(lives)

func goal():
	respawn()
	score += 1
	score_ui.text = "Score: " + str(score)
	get_parent().is_level_complete()

func respawn():
	mesh.hide() # Will show again once lerp is done
	weight = 1.0
	position = spawn_point
	to = spawn_point
	from = spawn_point
	mesh.rotation_degrees.y = 0
	collider.set_deferred("disabled", true)


func _process(delta: float) -> void:
	if lives < 0:
		return
	
	# If weight < 1.0, then we are lerping/moving
	if is_lerping == false:
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
		is_lerping = true
		weight += lerp_speed * delta
		position = lerp(from, to, weight)
	elif weight >= 1.0 and is_lerping == true:
		is_lerping = false
		weight = 1.0
		from = to
		mesh.show()
		collider.set_deferred("disabled", false)
	if riding_vessel:
		position.x = riding_vessel.global_position.x
		position.z = riding_vessel.global_position.z

	
func move(direction: Vector3, rotation: float):
	if direction == Vector3.FORWARD or direction == Vector3.BACK:
		riding_vessel = null
	from = position
	to = from - direction
	to.x = to.round().x
	to.z = to.round().z
	weight = 0.0
	mesh.rotation_degrees.y = rotation
	
func is_mobile_web() -> bool:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		return true
	elif OS.has_feature("mobile"):
		return true
	else:
		return false
