extends Node2D

@export var sprite = Sprite2D.new();
const IS_STRING_TARGET = 0;

signal string_to_me

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	if Input.is_action_just_pressed("string_launched"):
		if sprite.get_rect().has_point(to_local(event.position)):
			emit_signal('string_to_me')
