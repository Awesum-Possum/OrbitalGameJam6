extends Node2D

@export var ndiscret = 2
@export var mass = 50.0

var nodeImg = preload("res://icon.svg")

var target = null;
var joints = []
var bodies = []


var parts = []
var piece_length = 4.0
var rope_close_tolerance = 4.0

var RopePiece = preload("res://rope/RopePiece.tscn")

@onready var rope_start_piece = $RopeStartPiece
@onready var rope_end_piece = $RopeEndPiece

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func spawn_rope(start : Vector2, end : Vector2):
	rope_start_piece.global_position = start
	rope_start_piece.global_position = end
	start = rope_start_piece.get_node('C/Pin').global_position
	end = rope_end_piece.get_node('C/Pin').global_position
	
	var distance = start.distance_to(end)
	var amount = round(distance / piece_length)
	var spawn_angle = (start - end).angle() - PI/2
	
	create_rope(amount, rope_start_piece, end, spawn_angle)

		
func create_rope(piece_amount:int, parent:Object, end_pos:Vector2, spawn_angle:float):
	
	for i in piece_amount:
		parent = add_piece(parent, i, spawn_angle)
		parent.set_name('rope_piece'+str(i))
		parts.append(parent)
		
		var joint_pos = parent.get_node('C/Pin').global_position
		if joint_pos.distance_to(end_pos) < rope_close_tolerance:
			break
			
	rope_end_piece.get_node('C/Pin').node_a = rope_end_piece.get_path()
	rope_end_piece.get_node('C/Pin').node_b = parts[-1].get_path()
	
	
func add_piece(parent : Object, id: int, spawn_angle : float):
	var joint : PinJoint2D = parent.get_node('C/Pin') as PinJoint2D
	var piece : Object = RopePiece.instantiate() as Object
	piece.global_position = joint.global_position
	piece.rotation = spawn_angle
	#piece.parent = self
	#piece.id = id
	add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	
	return piece
	

# object must be a PhysicsBody2D
func on_target_fix(object):
	
	# fix target
	target = object
	
	# get location and distance
	var distance = get_parent().global_position.distance_to(object.global_position)
	var direction = object.global_position - get_parent().global_position
	
	# create pointlike physics2D
	for i in range(ndiscret):
		
		# create and link body
		var body = RigidBody2D.new()
		body.mass = mass / ndiscret
		#body.limit_angular_velocity = true
		#body.angular_velocity_limit = 1.0
		
		var sprite = Sprite2D.new()
		sprite.texture = nodeImg
		
		# add sprite to node
		body.add_child(sprite)
		
		# set body positions
		var relative_position = (i+1) * direction / ndiscret
		body.position = relative_position
		
		# link body
		add_child(body)
		bodies.append(body)
		
	for i in range(ndiscret):
		# create and link joint
		var joint = PinJoint2D.new()
		joint.softness = 0.5
		
		#joint.length = distance / (ndiscret + 1)
		
		# link joint
		add_child(joint)
		joints.append(joint)
		
		# link joints
		if i == 0:
			joint.node_a = $EndPoint.get_path()
		elif i > 0:
			joint.node_a = bodies[i].get_path()
			
		if i < ndiscret-1:
			joint.node_b = bodies[i+1].get_path()
			
		
	# create and link last joint
	var joint = PinJoint2D.new()
	add_child(joint)
	joints.append(joint)
	#joint.length = distance / (ndiscret + 1)
	joint.node_a = bodies[ndiscret-1].get_path()
	joint.node_b = target.get_path()

func on_target_release():
	
	# release target
	target = null
	
	# destroy joints
	for joint in joints:
		remove_child(joint)

# get endpoint position
func endpoint_velocity():
	return $EndPoint.linear_velocity
