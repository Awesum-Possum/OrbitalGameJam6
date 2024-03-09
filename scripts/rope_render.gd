extends Node2D

var nodes = []
@export var amount : int = 20
@export var texture : Texture2D = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func spawn_rope(start : Vector2, end : Vector2):
	for i in range(amount):
		var node = Sprite2D.new()
		node.texture = texture
		
		var pos = (end - start) / amount
		node.global_position = pos
		
		add_child(node)
		nodes.append(node)
		
	
func update_rope(start : Vector2, end : Vector2):
	for i in range(amount):
		nodes[i].global_position = (end - start) / amount
