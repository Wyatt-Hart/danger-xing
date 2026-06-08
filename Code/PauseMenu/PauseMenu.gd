extends PanelContainer
class_name PauseMenu

@onready var label: Label = $VBox/Label
@onready var start_button: Button = $VBox/StartButton
@onready var resume_button: Button = $VBox/ResumeButton
@onready var restart_button: Button = $VBox/RestartButton
@onready var quit_button: Button = $VBox/QuitButton

var main: Main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Signal Hooks
	start_button.pressed.connect(on_play)
	resume_button.pressed.connect(on_resume)
	restart_button.pressed.connect(on_restart)
	quit_button.pressed.connect(on_quit)

	# Setup UI for Main Menu
	main = get_parent()
	make_main_menu()
	
	show()
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused
	

func on_play():
	make_pause_menu()
	self.hide()
	main.load_level(main.level_files[0])

func on_resume():
	get_tree().paused = false
	self.hide()

func on_restart():
	main.load_level(main.level_files[0])

func on_quit():
	get_tree().quit()

# UI Changes
func make_pause_menu():
	label.text = "Paused"
	start_button.hide()
	resume_button.show()
	restart_button.hide()

func make_main_menu():
	label.text = "Danger X-ing"
	start_button.show()
	resume_button.hide()
	restart_button.hide()

func make_game_over():
	label.text = "Game Over!"
	start_button.hide()
	resume_button.hide()
	restart_button.show()
