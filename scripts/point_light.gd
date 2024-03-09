class_name MyLight extends Node2D

@export var decay_time = 10
@export var min_energy = 0.1
@export var decays = false

var current_time = 0

@onready var light1: PointLight2D = $TextureLight
@onready var light2: PointLight2D = $Shadow

@onready var initial_light1 = light1.energy
@onready var initial_light2 = light2.energy


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if decays:
		current_time += delta
		light1.energy = max(
			initial_light1 - (current_time / decay_time) * initial_light1, min_energy
		)
		light2.energy = max(
			initial_light2 - (current_time / decay_time) * initial_light2, min_energy
		)


## Reset the light to their initial values
func reset():
	current_time = 0
	light1.energy = initial_light1
	light2.energy = initial_light2
