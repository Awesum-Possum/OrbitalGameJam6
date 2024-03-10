class_name MyLight extends Node2D

## The time it takes for the light to decay
@export var decay_time = 10
## The minimum energy the light can have
@export var min_energy = 1
## Whether the light should decay or not
@export var decays = false

var _current_time = 0

@onready var light1: PointLight2D = $TextureLight
@onready var light2: PointLight2D = $Shadow

@onready var initial_light1 = light1.scale.x
@onready var initial_light2 = light2.scale.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if decays:
		_current_time += delta
		var l_scale = max(
			initial_light1 - (_current_time / decay_time) * initial_light1, min_energy
		)
		light1.scale = Vector2(l_scale, l_scale)
		light2.energy = max(
			initial_light2 - (_current_time / decay_time) * initial_light2, min_energy
		)


## Reset the light to their initial values
func reset():
	_current_time = 0
	light1.energy = initial_light1
	light2.energy = initial_light2
	decays = true


## Turn off the light
func turn_off():
	light1.enabled = false
	light2.enabled = false
	decays = false
	visible = false
