class_name Light2 extends PointLight2D

@export var decays: bool = false
@export var decay_time: float = 10
@export var min_scale = 0.1

var _current_time: float = 0
@onready var init_scale = scale.x

var _tween: Tween

func _ready():
	start_decay()

func start_decay():
	if decays:
		_tween = create_tween()
		_tween.tween_property(self, "scale", Vector2(min_scale*init_scale, min_scale*init_scale), decay_time)



## Reset the light to their initial values
func reset():
	if _tween:
		_tween.kill()
		_tween = null

	_current_time = 0
	_tween = create_tween()
	_tween.tween_property(self, "scale", Vector2(init_scale, init_scale), 1).set_trans(Tween.TRANS_SINE)
	_tween.tween_callback(start_decay)


## Turn off the light
func turn_off():
	enabled = false
	decays = false
	visible = false
