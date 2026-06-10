extends PanelContainer
class_name PauseMenu

@onready var label: Label = $VBox/Label
@onready var start_button: Button = $VBox/StartButton
@onready var resume_button: Button = $VBox/ResumeButton
@onready var restart_button: Button = $VBox/RestartButton
@onready var quit_button: Button = $VBox/QuitButton
var is_pause_menu: bool = false
var new_game_plus: int = 0

var main: Main

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Signal Hooks
	start_button.pressed.connect(on_start)
	resume_button.pressed.connect(on_resume)
	restart_button.pressed.connect(on_restart)
	quit_button.pressed.connect(on_quit)

	# Setup UI for Main Menu
	main = get_parent()
	show_main_menu()
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause") and is_pause_menu:
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused
	

func on_start():
	show_pause_menu()
	self.hide()
	main.new_game_plus_level += 1
	main.load_level(main.level_files[0])

func on_resume():
	get_tree().paused = false
	self.hide()

func on_restart():
	main.load_level(main.level_files[0])
	self.hide()

func on_quit():
	get_tree().quit()

# UI Changes
func show_pause_menu():
	label.text = "Paused"
	is_pause_menu = true
	start_button.hide()
	resume_button.show()
	restart_button.hide()

func show_main_menu():
	label.text = "Danger X-ing"
	is_pause_menu = false
	start_button.show()
	resume_button.hide()
	restart_button.hide()
	self.show()

func show_game_over():
	label.text = "Game Over!"
	is_pause_menu = false
	start_button.hide()
	resume_button.hide()
	restart_button.show()
	self.show()

func show_victory_screen():
	label.text = "Congratulations!\nYou Win"
	is_pause_menu = false
	start_button.text = "New Game +"
	start_button.show()
	resume_button.hide()
	restart_button.hide()
	self.show()
