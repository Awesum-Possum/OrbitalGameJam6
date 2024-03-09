extends Node2D

@export var ndiscret = 2
@onready var nodeSprite = $StringNode;

var target = null;
var joints = []
var bodies = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# object must be a PhysicsBody2D
func on_target_fix(object):
	
	# fix target
	target = object
	
	# get location and distance
	#var distance = get_parent().global_position.distance_to(object.global_position)
	var direction = object.global_position - get_parent().global_position
	
	# create pointlike physics2D
	for i in range(ndiscret - 1):
		
		# create and link body
		var body = RigidBody2D.new()
		
		# add sprite to node
		body.add_child(nodeSprite)
		
		# set body positions
		var relative_position = (i+1) * direction / ndiscret
		body.position = relative_position
		
		# link body
		add_child(body)
		bodies.append(body)
	
	# create joints and attach them
	for i in range(ndiscret):
		
		# create and link joint
		var joint = DampedSpringJoint2D.new()
		
		# link joints
		if i == 0:
			joint.node_a = get_parent()
		elif i > 0:
			joint.node_a = joints[i-1]
			
		if i < ndiscret-1:
			joint.node_b = joints[i+1]
		elif i == ndiscret-1:
			joint.node_b = target
		
		# link joint
		add_child(joint)
		joints.append(joint)


func on_target_release():
	
	# release target
	target = null
	
	# destroy joints
	for joint in joints:
		remove_child(joint)
	
