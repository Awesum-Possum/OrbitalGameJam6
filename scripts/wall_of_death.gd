class_name WallOfDeath extends Area2D

@export var speed = 400
## The gap, in pixel, between each mob
@export var mob_gab = 35
## The number of frames in the mob animation
@export var nb_frames = 7

var dog_scene := preload("res://doggo.tscn")
var game_over = preload("res://game_over.tscn")

@onready var player: Player = %Player
@onready var mobs: Node2D = $Mobs
@onready var mesh: MeshInstance2D = $MeshInstance2D


func _ready():
	var start_pos = mesh.scale.y / 2
	for i in range(0, mesh.scale.y, mob_gab):
		var dog = dog_scene.instantiate()
		dog.position.y = start_pos - i
		dog.frame = randi() % nb_frames
		mobs.add_child(dog)


func _process(delta):
	position.x += speed * delta
	mobs.move(player.position.y)


func _on_body_entered(body: Node2D):
	if body is Player:
		Globals.game_over.emit()
		speed = 3000
		get_tree().create_timer(0.5).timeout.connect(show_game_over)


func show_game_over():
	speed = 0
	get_tree().root.add_child(game_over.instantiate())