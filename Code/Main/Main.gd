extends Node
class_name Main

@export var goals: Array[Goal]


func is_game_over() -> bool:
	for goal in goals:
		if not goal.is_occupied:
			return false
	return true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	goals[0].occupy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
