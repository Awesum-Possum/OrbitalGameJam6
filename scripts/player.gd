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

var Rope = preload("res://rope/Rope.tscn")

var string_attached = false
var string_target_reachable = []
var rope = null
var rope_force = 50

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += Globals.GRAVITY * delta
		
	# keep fixed to string/rope
	if string_attached:
		var end_pos = get_global_mouse_position() 
		var start_pos = global_position
		
		# apply force proportional to distance
		velocity += (end_pos - start_pos) * rope_force * delta
		rope.update_rope(start_pos, end_pos)

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
	
	
# rope handlers
func _on_activate_string(object):
	if not string_attached:
		print("Attaching string")
		string_attached = true
		
		var end_pos = get_global_mouse_position() 
		var start_pos = global_position
		
		rope = Rope.instantiate()
		rope.texture = load("res://icon.svg")
		add_child(rope)
		rope.spawn_rope(start_pos, end_pos)
	
func _on_release_string():
	print("Detaching string")
	string_attached = false
	remove_child(rope)
	rope = null


# register targettable body
func _on_string_detector_body_entered(body):
	# add body if it is a target
	for child in body.get_children():
		if 'IS_STRING_TARGET' in child:
			print("Potential target enter view")
			child.connect('string_to_me', _on_activate_string)
			string_target_reachable.append(body)
			break

# unregister targettable body
func _on_string_detector_body_exited(body):
	var index = string_target_reachable.find(body)
	if index != -1:
		
		# find child with signal
		for child in body.get_children():
			if 'IS_STRING_TARGET' in child:
				print("Potential target exit")
				child.disconnect('string_to_me', _on_activate_string)
				break
		
		# remove body from list
		string_target_reachable.remove_at(index)
