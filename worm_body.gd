extends Node2D

const segments = 20
var segments_storage = {}

func _ready() -> void:
	for i in range(0, segments):
		segments_storage[i] = $Wormbody.duplicate()
		(segments_storage[i] as Node2D).position.x = 6*4 * i
		(segments_storage[i] as Node2D).visible = true
		add_child(segments_storage[i] as Node2D)



func _process(delta: float) -> void:
	pass
