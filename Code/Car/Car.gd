extends Area3D
class_name Car

var lane: Lane = null
var speed = 0.0 # m/s



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Parent of Car should be Lane
	lane = get_parent()
	speed = lane.speed_limit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > lane.despawn_point:
		position.x = lane.spawn_point
