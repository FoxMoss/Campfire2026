extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_button_down() -> void:
	get_node("/root/Static").segments = 6
	get_node("/root/Static").current_level = 0
	get_tree().change_scene_to_file("res://level_up.tscn")
	pass # Replace with function body.
