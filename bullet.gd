extends CharacterBody2D


const SPEED = 500.0

func _physics_process(delta: float) -> void:
	
	velocity = Vector2.from_angle(self.rotation).normalized() * SPEED
	
	move_and_slide()
