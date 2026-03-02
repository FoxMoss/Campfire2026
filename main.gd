extends Node2D
var start_time
var day = true
var eliminate_count = 0
var quota = 5

var since_last_bullet

@onready var bullet_low = $BulletManager/BulletLowValue
@onready var bullet_high = $BulletManager/BulletHighValue

@export var bullet_pickup: PackedScene


var bullet_pos:Vector2 = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	generate_bullet()
	
	since_last_bullet = Time.get_ticks_msec()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = (Time.get_ticks_msec() - start_time) / 1000
	if $ProgressBar.value >= 60:
		day = !day
		start_time = Time.get_ticks_msec()
	
	$Label.text = str(eliminate_count) +"/"+ str(quota) +" Eliminated \nAmmo: " + str($Player.bullets) + "/" + str($Player.max_bullets)
	
	if Time.get_ticks_msec() >= ((randf_range(6, 11)*1000) + since_last_bullet):
		since_last_bullet = Time.get_ticks_msec()
		generate_bullet()
func generate_bullet() -> void:
	bullet_pos.x = randf_range(bullet_low.global_position.x, bullet_high.global_position.x)
	bullet_pos.y = randf_range(bullet_low.global_position.y, bullet_high.global_position.y)
	var spawn_bullet = bullet_pickup.instantiate() as Node2D
	spawn_bullet.global_position = bullet_pos
	add_child(spawn_bullet)
