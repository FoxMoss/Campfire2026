extends Node

const levels = [
	{"level":"Level 1", "quota": 1, "build_instructions": [["add_bird", 1]]},
	{"level":"Level 2", "quota": 3, "build_instructions": [["add_bird", 3]]},
	{"level":"Level 3", "quota": 5, "build_instructions": [["add_bird", 8]]},
	{"level":"Level 4", "quota": 10, "build_instructions": [["add_bird", 15]]},
	{"level":"Level 5", "quota": 15, "build_instructions": [["add_bird", 25]]},
	{"level":"Level 6", "quota": 20, "build_instructions": [["add_bird", 30]]},
	{"level":"Level 7", "quota": 25, "build_instructions": [["add_bird", 35]]},
	{"level":"Level 8", "quota": 25, "build_instructions": [["add_bird", 35]]},
	{"level":"The End", "quota": 0, "build_instructions": [["end"]]}
]

var current_level = 0

var segments = 6

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
