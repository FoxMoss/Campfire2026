extends Node2D
var start_time
var day = true
var eliminate_count = 0
var quota = 5

@onready var bullet_low = $BulletManager/BulletLowValue
@onready var bullet_high = $BulletManager/BulletHighValue

@export var bullet_pickup: PackedScene


var bullet_pos:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	generate_bullets()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = (Time.get_ticks_msec() - start_time) / 1000
	if $ProgressBar.value >= 10:
		day = !day
		start_time = Time.get_ticks_msec()
		get_node("/root/Static").current_level += 1
		get_node("/root/Main").queue_free()
		get_tree().change_scene_to_file("res://level_up.tscn")
	
	$Label.text = str(eliminate_count) +"/"+ str(quota) +" Eliminated \nAmmo: " + str($Player.bullets) + "/" + str($Player.max_bullets)
	
func generate_bullets() -> void:
	bullet_pos.x = randf_range(bullet_low.global_position.x, bullet_high.global_position.x)
	bullet_pos.y = randf_range(bullet_low.global_position.y, bullet_high.global_position.y)
	var spawn_bullet = bullet_pickup.instantiate() as Node2D
	spawn_bullet.global_position = bullet_pos
	add_child(spawn_bullet)
