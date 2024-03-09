extends Area2D

const IS_STRING_TARGET = 0;

signal string_to_me

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input_event(viewport: Object, event: InputEvent, shape_idx: int):
	if Input.is_action_just_pressed("string_launched"):
		print("String target clicked")
		emit_signal('string_to_me', get_parent())
