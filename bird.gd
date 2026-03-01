extends Area2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

enum AIMode {
	BIRD_HOVERING,
	BIRD_ATTACK,
	BIRD_DYING
}

var mode = AIMode.BIRD_HOVERING

var bird_low: Node2D
var bird_high: Node2D

func _ready() -> void:
	bird_low = get_parent().get_child(0) as Node2D
	bird_high = get_parent().get_child(1) as Node2D
	global_position.x = randf_range(bird_low.global_position.x, bird_high.global_position.x)
	global_position.y = randf_range(bird_low.global_position.y, bird_high.global_position.y)
	
	

func _physics_process(delta: float) -> void:
	pass
