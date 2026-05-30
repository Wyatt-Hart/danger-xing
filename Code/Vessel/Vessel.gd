extends Area3D
class_name Vessel

var river: River = null
var speed = 0.0 # m/s


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	river = get_parent()
	speed = river.speed_limit


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > river.despawn_point:
		position.x = river.spawn_point
