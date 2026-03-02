extends Node2D

var segments = 6
var segments_storage = {}
var segments_position_storage = {}
var dist = 6*4
@export var gravity = false

func _ready() -> void:
	segments = get_node("/root/Static").segments
	for i in range(0, segments):
		segments_storage[i] = $Wormbody.duplicate()
		(segments_storage[i] as Node2D).position.x = dist * i
		segments_position_storage[i] = (segments_storage[i] as Node2D).global_position
		(segments_storage[i] as Node2D).visible = i != 0
		add_child(segments_storage[i] as Node2D)

func _process(delta: float) -> void:
	if(segments <= 0):
		get_node("/root/Main").queue_free()
		get_tree().change_scene_to_file("res://game_over.tscn")
		return
	(segments_storage[0] as Node2D).global_position = self.global_position
	
	for i in range(1, segments):
		(segments_storage[i] as Node2D).global_position = segments_position_storage[i]
		var direction = ((segments_storage[i] as Node2D).global_position - (segments_storage[i-1] as Node2D).global_position).normalized()
		if ((segments_storage[i] as Node2D).global_position.y < 0):
			direction = Vector2.from_angle(lerp_angle(direction.angle(), 0.5*PI, 0.08)).normalized()
		
		(segments_storage[i] as Node2D).global_position = (segments_storage[i-1] as Node2D).global_position + direction * dist
		
		segments_position_storage[i] = (segments_storage[i] as Node2D).global_position
	
	
func remove_tail():
	if(segments <= 0):
		return
	segments -= 1
	get_node("/root/Static").segments = segments
	(segments_storage[segments] as Node2D).queue_free()
	segments_storage.erase(segments)
	segments_position_storage.erase(segments)
