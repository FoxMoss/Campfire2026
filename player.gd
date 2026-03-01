extends CharacterBody2D

@export var camera:NodePath

@export var SPEED = 300.0
@export var acceleration = 0.1
@export var bullet: PackedScene

var mode = 0 # mode 0 is below and 1 is above



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
			velocity.x = move_toward(velocity.x, 0, SPEED/10)
		
		if vertical_direction:
			velocity.y += vertical_direction * SPEED * acceleration
			velocity.y = clamp(velocity.y, -SPEED, SPEED)
		else:
			velocity.y = move_toward(velocity.y, 0, SPEED/10)
	else:
		velocity.y += 3
		var horizontal_direction := Input.get_axis("ui_left", "ui_right")
		var vertical_direction := Input.get_axis("ui_up", "ui_down")
	
		$Face.rotation = lerp_angle($Face.rotation, Vector2(horizontal_direction, vertical_direction).angle(), 0.3)
		
		if(Input.is_action_just_pressed("shoot")):
			var new_bullet = bullet.instantiate() as Node2D
			new_bullet.global_position = global_position
			new_bullet.rotation = $Face.rotation
			get_parent().add_child(new_bullet)
			
	
	if position.y < 0: #above ground
		if(mode != 1):
			velocity += Vector2.from_angle($Face.rotation).normalized() * SPEED * 0.5
		mode = 1
	else: #below ground
		mode = 0
	

	move_and_slide()
