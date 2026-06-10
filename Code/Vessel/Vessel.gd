extends Area3D
class_name Vessel

var river: River = null
var main: Main
var speed = 0.0 # m/s
var new_game_plus_modifier: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	river = get_parent()
	main = river.get_parent().get_parent()
	new_game_plus_modifier = main.new_game_plus_level
	speed = river.speed_limit + new_game_plus_modifier


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta
	if position.x > river.despawn_point:
		position.x = river.spawn_point
