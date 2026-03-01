extends CharacterBody2D


@export var SPEED = 300.0

@export var acceleration = 0.1

func _physics_process(delta: float) -> void:
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var horizontal_direction := Input.get_axis("ui_left", "ui_right")
	var vertical_direction := Input.get_axis("ui_up", "ui_down")
	
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

	move_and_slide()
