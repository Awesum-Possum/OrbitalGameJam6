extends Node2D

@export var decay_time = 10
@export var min_energy = 0.1
@export var decays = false


@onready var light1 = $TextureLight
@onready var light2 = $Shadow

@onready var initial_light1 = light1.energy
@onready var initial_light2 = light2.energy


var current_time = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if decays:
		current_time += delta
		light1.energy = max(initial_light1 - (current_time / decay_time)*initial_light1, min_energy)
		light2.energy = max(initial_light2 - (current_time / decay_time)*initial_light2, min_energy)

func reset():
	current_time = 0
	light1.energy = initial_light1
	light2.energy = initial_light2
