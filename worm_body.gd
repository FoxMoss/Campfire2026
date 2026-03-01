extends Node2D

const segments = 20
var segments_storage = {}
var segments_position_storage = {}
var dist = 6*4
@export var gravity = false

func _ready() -> void:
	for i in range(0, segments):
		segments_storage[i] = $Wormbody.duplicate()
		(segments_storage[i] as Node2D).position.x = dist * i
		segments_position_storage[i] = (segments_storage[i] as Node2D).global_position
		(segments_storage[i] as Node2D).visible = i != 0
		add_child(segments_storage[i] as Node2D)

func _process(delta: float) -> void:
	(segments_storage[0] as Node2D).global_position = self.global_position
	
	for i in range(1, segments):
		(segments_storage[i] as Node2D).global_position = segments_position_storage[i]
		var direction = ((segments_storage[i] as Node2D).global_position - (segments_storage[i-1] as Node2D).global_position).normalized()
		if ((segments_storage[i] as Node2D).global_position.y < 0):
			direction = Vector2.from_angle(lerp_angle(direction.angle(), 0.5*PI, 0.08)).normalized()
		
		(segments_storage[i] as Node2D).global_position = (segments_storage[i-1] as Node2D).global_position + direction * dist
		
		segments_position_storage[i] = (segments_storage[i] as Node2D).global_position
	
	
