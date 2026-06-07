extends Area3D
class_name Goal


@onready var chicken: Node3D = $Chicken
var is_occupied: bool = false

func _ready() -> void:
	chicken.hide()

#TODO:
# - [ ] Jitter during the occupy().
# - [x] Show chicken.
# - [ ] Does the player care?

func occupy():
	is_occupied = true
	chicken.show()
