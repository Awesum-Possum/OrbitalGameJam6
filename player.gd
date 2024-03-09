extends CharacterBody2D

@export var speed = 1200
@export var gravity = 4000
@export var jump_velocity = 1800
@export_range(0.0, 1.0) var friction = 0.1
@export_range(0.0, 1.0) var acceleration = 0.25


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# minus since jump up is negative
		velocity.y = -jump_velocity

	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	move_and_slide()
