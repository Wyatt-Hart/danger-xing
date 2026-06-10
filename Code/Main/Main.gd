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

func _ready() -> void:
	# Level Ordering
	level_files.append(LEVEL_1)
	level_files.append(LEVEL_2)
	level_files.append(LEVEL_3)
	load_level(MainMenu)


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
	load_level(level_files[level_index])

func game_over():
	pause_menu.show_game_over()
