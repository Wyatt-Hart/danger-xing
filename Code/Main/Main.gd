extends Node
class_name Main

const MainMenu = preload("res://Levels/MainMenu.tscn")
const LEVEL_1 = preload("res://Levels/Level1.tscn")
const LEVEL_2 = preload("res://Levels/Level2.tscn")
const LEVEL_3 = preload("res://Levels/Level3.tscn")

@onready var pause_menu: PauseMenu = $PauseMenu

var level_files: Array[PackedScene]
var level: Level = null
var level_index: int = 0
var new_game_plus_level = 0

func _ready() -> void:
	# Level Ordering
	level_files.append(LEVEL_1)
	level_files.append(LEVEL_2)
	level_files.append(LEVEL_3)
	load_level(MainMenu)
	
	# Fix UI for Mobile
	if is_web_mobile():
		get_tree().root.content_scale_factor = 3


func load_level(scene: PackedScene):
	if level != null:
		level.queue_free()
	level = scene.instantiate()
	add_child(level)

func next_level():
	level_index += 1

	if level_index > level_files.size() - 1:
		print("Starting NG+")
		level_index = 0;
		pause_menu.show_victory_screen()
	else:
		load_level(level_files[level_index])

func game_over():
	pause_menu.show_game_over()
	
func is_web_mobile() -> bool:
	if OS.has_feature("web_android") or OS.has_feature("web_ios"):
		return true
	elif OS.has_feature("mobile"):
		return true
	else:
		return false
