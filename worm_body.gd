extends Node2D

const segments = 20
var segments_storage = {}
var segments_position_storage = {}
var dist = 6*4

func _ready() -> void:
	for i in range(0, segments):
		segments_storage[i] = $Wormbody.duplicate()
		(segments_storage[i]  as Node2D).position.x = dist * i
		segments_position_storage[i] = (segments_storage[i] as Node2D).global_position
		(segments_storage[i] as Node2D).visible = i != 0
		add_child(segments_storage[i] as Node2D)

func _process(delta: float) -> void:
	(segments_storage[0] as Node2D).global_position = self.global_position
	
	for i in range(1, segments):
		(segments_storage[i] as Node2D).global_position = segments_position_storage[i]
		(segments_storage[i] as Node2D).global_position = (segments_storage[i-1] as Node2D).global_position + ((segments_storage[i] as Node2D).global_position - (segments_storage[i-1] as Node2D).global_position).normalized() * dist
		segments_position_storage[i] = (segments_storage[i] as Node2D).global_position
	pass
