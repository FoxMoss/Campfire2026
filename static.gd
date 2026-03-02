extends Node

const levels = [
	{"level":"Level 1", "quota": 1, "build_instructions": [["add_bird", 1]]},
	{"level":"Level 2", "quota": 3, "build_instructions": [["add_bird", 3]]},
	{"level":"The End", "quota": 0, "build_instructions": [["end"]]}
]

var current_level = 0

var bird = preload("res://bird.tscn")
var main = preload("res://Main.tscn")

func build_level():
	get_node("/root/LevelUp").queue_free()
	get_tree().root.add_child(main.instantiate())
	var level = levels[current_level]
	get_node("/root/Main").quota = level.quota
	
	for instruction in level.build_instructions:
		if(instruction[0] == "add_bird"):
			for i in range(0, instruction[1]):
				get_node("/root/Main/BirdManager").add_child(bird.instantiate())
			
		if(instruction[0] == "end"):
			get_node("/root/Main").queue_free()
			get_tree().change_scene_to_file("res://win.tscn")
