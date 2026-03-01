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

var bird_hover_pos: Vector2 = Vector2.ZERO
var target_pos: Vector2 = Vector2.ZERO
@export var blast_scene: PackedScene


func _ready() -> void:
	bird_low = get_parent().get_child(0) as Node2D
	bird_high = get_parent().get_child(1) as Node2D
	bird_hover_pos.x = randf_range(bird_low.global_position.x, bird_high.global_position.x)
	bird_hover_pos.y = randf_range(bird_low.global_position.y, bird_high.global_position.y)
	target_pos = bird_hover_pos + Vector2(randf_range(-20, 20), randf_range(-20, 20))
	global_position = bird_hover_pos
	$Timer.wait_time = randf_range(0.5, 0.9)
	

func _physics_process(delta: float) -> void:
	global_position.x = lerp(global_position.x, target_pos.x, 0.05)
	global_position.y = lerp(global_position.y, target_pos.y, 0.05)
	pass


func _on_timer_timeout() -> void:
	$Timer.wait_time = randf_range(0.5, 0.9)
	$Bird.flip_h = !$Bird.flip_h
	if(mode == AIMode.BIRD_HOVERING):
		target_pos = bird_hover_pos + Vector2(randf_range(-50, 50), randf_range(-50, 50))
		if(randi_range(0, 10) == 0):
			mode = AIMode.BIRD_ATTACK
			
			target_pos = Vector2(get_node("/root/Main/Player").global_position.x + randf_range(-100, 100), 0)
		elif(randi_range(0, 10) == 0):
			
			bird_hover_pos.x = randf_range(bird_low.global_position.x, bird_high.global_position.x)
			bird_hover_pos.y = randf_range(bird_low.global_position.y, bird_high.global_position.y)
			target_pos = bird_hover_pos + Vector2(randf_range(-20, 20), randf_range(-20, 20))
	if(mode == AIMode.BIRD_ATTACK && global_position.distance_to(target_pos) < 10):
		var blast = blast_scene.instantiate()
		get_parent().get_child(2).add_child(blast)
		blast.global_position = global_position + Vector2(0, 20)
		mode = AIMode.BIRD_HOVERING
			
		bird_hover_pos.x = randf_range(bird_low.global_position.x, bird_high.global_position.x)
		bird_hover_pos.y = randf_range(bird_low.global_position.y, bird_high.global_position.y)
		
	if(mode == AIMode.BIRD_DYING):
		get_parent().get_parent().eliminate_count += 1
		queue_free()
	

func _on_body_entered(body: Node2D) -> void:
	mode = AIMode.BIRD_DYING
	$Bird.visible = false
	$Explosion.visible = true
	$Timer.start()
