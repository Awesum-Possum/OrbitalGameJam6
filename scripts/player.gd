class_name Player extends CharacterBody2D

## The speed of the player.
@export var speed = 1200
## The velocity of the jump.
@export var jump_velocity = 1800
## The air control of the player.
@export_range(0.0, 1.0) var air_control = 0.5
## The friction of the player when stopping.
@export_range(0.0, 1.0) var friction = 0.1
## The acceleration of the player.
@export_range(0.0, 1.0) var acceleration = 0.25

## A modifier on the players speed when stuck.
var stuck_force = 0

@onready var light = $Light


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += Globals.GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# minus since jump up is negative
		velocity.y -= jump_velocity

	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		if not is_on_floor():
			direction *= air_control

		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)

	if stuck_force > 0:
		velocity /= stuck_force

	move_and_slide()


## Makes the player jump.
## @param force: The force of the jump.
func jump(force: int = 100):
	velocity.y = -force
	move_and_slide()


## Resets the light.
func regen_light():
	light.reset()
