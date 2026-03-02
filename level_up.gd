extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = 0
	for level in get_node("/root/Static").levels:
		var new_mission = $MissionObject.duplicate() as Node2D
		new_mission.position.x = index * 140
		new_mission.visible = true
		new_mission.get_child(1).text = level.level
		$MissionContainer.add_child(new_mission)
		index += 1
	$MissionContainer.global_position.x = (get_node("/root/Static").current_level - 1) * -140


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$MissionContainer.global_position.x = lerp($MissionContainer.global_position.x,  (get_node("/root/Static").current_level) * -140.0, 0.05)
	pass


func _on_timer_timeout() -> void:
	get_node("/root/Static").build_level()
