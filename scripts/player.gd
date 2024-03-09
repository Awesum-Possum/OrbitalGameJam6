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

@onready var light = $Light
@onready var physical_string = $PhysicalString

var string_attached = false
var string_target_reachable = []

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += Globals.GRAVITY * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		# minus since jump up is negative
		velocity.y = -jump_velocity

	var direction = Input.get_axis("walk_left", "walk_right")
	if direction:
		if not is_on_floor():
			direction *= air_control

		velocity.x = lerp(velocity.x, direction * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0.0, friction)
		
	# Handle release of string
	if Input.is_action_just_pressed("string_released") and string_attached:
		_on_release_string()

	move_and_slide()


## Makes the player jump.
## @param force: The force of the jump.
func jump(force: int = 100):
	velocity.y = -force
	move_and_slide()

func regen_light():
	print("Regen Light")
	light.reset()
	
func _on_activate_string(object):
	if not string_attached:
		string_attached = true
		physical_string.on_target_fix(object)
	
	
func _on_release_string():
	string_attached = false
	physical_string.on_target_release()


# register targettable body
func _on_string_detector_body_entered(body):
	# add body if it is a target
	for child in body.get_children():
		if 'IS_STRING_TARGET' in child:
			child.connect('string_to_me', self, '_on_activate_string')
			string_target_reachable.append(body)
			break

# unregister targettable body
func _on_string_detector_body_exited(body):
	var index = string_target_reachable.find(body)
	if index != -1:
		
		# find child with signal
		for child in body.get_children():
			if 'IS_STRING_TARGET' in child:
				child.disconnect('string_to_me', self, '_on_activate_string')
				break
		
		# remove body from list
		string_target_reachable.remove_at(index)
