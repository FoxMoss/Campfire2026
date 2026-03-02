extends Node

const levels = [
	{"level":"Level 1", "quota": 1, "build_instructions": [["add_bird", 1]]},
	{"level":"Level 2", "quota": 3, "build_instructions": [["add_bird", 3]]},
	{"level":"Level 3", "quota": 5, "build_instructions": [["add_bird", 8]]},
	{"level":"Health Reset", "quota": 0, "build_instructions": [["up_health", 6]]},
	{"level":"Level 4", "quota": 10, "build_instructions": [["add_bird", 15]]},
	{"level":"Level 5", "quota": 15, "build_instructions": [["add_bird2", 1]]},
	{"level":"Level 6", "quota": 15, "build_instructions": [["add_bird2", 1], ["add_bird", 10]]},
	{"level":"Level 7", "quota": 20, "build_instructions": [["add_bird2", 4], ["add_bird", 15]]},
	{"level":"Level 8", "quota": 25, "build_instructions": [["add_bird2", 4], ["add_bird", 30]]},
	{"level":"Health Reset", "quota": 0, "build_instructions": [["up_health", 6]]},
	{"level":"Level 9", "quota": 30, "build_instructions": [["add_bird2", 4], ["add_bird", 40]]},
	{"level":"The End", "quota": 0, "build_instructions": [["end"]]}
]

var current_level = 0

var segments = 6

var bird = preload("res://bird.tscn")
var bird2 = preload("res://birdtoo.tscn")
var main = preload("res://Main.tscn")

func build_level():
	get_node("/root/LevelUp").queue_free()
	var level = levels[current_level]
	
	var should_switch = true
	
	for instruction in level.build_instructions:
		if(instruction[0] == "up_health"):
			get_node("/root/Static").segments = instruction[1]
			current_level += 1
			get_tree().change_scene_to_file("res://level_up.tscn")
			should_switch = false
		if(instruction[0] == "end"):
			get_tree().change_scene_to_file("res://win.tscn")
			should_switch = false
			
	
	if should_switch:
		get_tree().root.add_child(main.instantiate())
		get_node("/root/Main").quota = level.quota
		for instruction in level.build_instructions:
			if(instruction[0] == "add_bird"):
				for i in range(0, instruction[1]):
					get_node("/root/Main/BirdManager").add_child(bird.instantiate())
				
			if(instruction[0] == "add_bird2"):
				for i in range(0, instruction[1]):
					get_node("/root/Main/BirdManager").add_child(bird2.instantiate())
	
