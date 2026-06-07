extends Node3D
class_name Level

var main: Main
@export var goals: Array[Goal]

func _ready() -> void:
	main = get_parent()

	# Check level for goals, append to goals array
	for child in get_children():
		if child is Goal:
			goals.append(child)


func is_level_complete() -> bool:
	if goals.size() <= 0:
		print("ERROR: No goals found")
		return false

	for goal in goals:
		print(goal.is_occupied)
		if not goal.is_occupied:
			print("Keep going!")
			return false

	print("Level Complete!")
	main.next_level()
	return true
