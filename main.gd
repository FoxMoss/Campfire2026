extends Node2D
var start_time
var day = true
var eliminate_count = 0
var quota = 5

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_time = Time.get_ticks_msec()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = (Time.get_ticks_msec() - start_time) / 1000
	if $ProgressBar.value >= 60:
		day = !day
		start_time = Time.get_ticks_msec()
	
	$Label.text = str(eliminate_count) +"/"+ str(quota) +" Eliminated \nAmmo: " + str($Player.bullets) + "/" + str($Player.max_bullets)
	pass
