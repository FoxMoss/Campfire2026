extends CharacterBody2D

@export var camera:NodePath

@export var SPEED = 300.0
@export var acceleration = 0.1
var mode = 0 # mode 0 is below and 1 is above
var not_burning = 100

func _physics_process(delta: float) -> void:
	if mode == 0:
		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var horizontal_direction := Input.get_axis("ui_left", "ui_right")
		var vertical_direction := Input.get_axis("ui_up", "ui_down")
	
		$Face.rotation = lerp_angle($Face.rotation, Vector2(horizontal_direction, vertical_direction).angle(), 0.3)
	
		if horizontal_direction:
			velocity.x += horizontal_direction * SPEED * acceleration
			velocity.x = clamp(velocity.x, -SPEED, SPEED)
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
		
		if vertical_direction:
			velocity.y += vertical_direction * SPEED * acceleration
			velocity.y = clamp(velocity.y, -SPEED, SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED)
	else:
		velocity.y += 10
	
	if position.y < 0: #above ground
		if(mode != 1):
			velocity += Vector2.from_angle($Face.rotation).normalized() * SPEED
		mode = 1
		if $ProgressBar.value >= 0:
			$ProgressBar.value -= 50 * delta 
	else: #below ground
		mode = 0
		if $ProgressBar.value < 100:
			$ProgressBar.value += 15 * delta 
	

	move_and_slide()
