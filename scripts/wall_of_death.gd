class_name WallOfDeath extends Area2D

## The speed of the wall
@export var speed = 400
## The gap, in pixel, between each mob
@export var mob_gab = 35
## The number of frames in the mob animation
@export var nb_frames = 7
## The distance, in pixel, the wall will retract when flashed
@export var retract_distance = 1000
## The distance at wich the music will start to fade
@export var music_fade_distance = 2000
## The maximum volume of the music
@export var max_volume = 0
## The volume increase when approaching the wall
@export var volume_increase = 150

## Whether the wall is retracted or not
var retracted = false

var dog_scene := preload("res://doggo.tscn")
var game_over = preload("res://game_over.tscn")
var _max_retract = 0
var _trying_to_come_back = false
var _end = false

@onready var player: Player = %Player
@onready var mobs: Node2D = $Mobs
@onready var mesh: MeshInstance2D = $MeshInstance2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func _ready():
	var start_pos = mesh.scale.y / 2
	for i in range(0, mesh.scale.y, mob_gab):
		var dog = dog_scene.instantiate()
		dog.position.y = start_pos - i
		dog.frame = randi() % nb_frames
		mobs.add_child(dog)


func _process(delta):
	var trying_distance = retract_distance / 2.0
	if _trying_to_come_back and position.x >= _max_retract + trying_distance:
		_trying_to_come_back = false

	if not retracted or _end:
		position.x += speed * delta
	elif retracted and position.x > _max_retract and not _trying_to_come_back:
		position.x -= speed * 5 * delta
	elif retracted and position.x <= _max_retract and not _trying_to_come_back:
		_trying_to_come_back = true
	elif _trying_to_come_back and position.x < _max_retract + trying_distance:
		position.x += speed * delta

	mobs.move(player.position.y)

	_fade_music()


func _on_body_entered(body: Node2D):
	var p = body as Player
	if p:
		var should_show_game_over = not p.game_over
		if should_show_game_over:
			Globals.game_over.emit()
		speed = 3000
		_end = true
		get_tree().create_timer(0.5).timeout.connect(func(): show_game_over(should_show_game_over))


## Show the game over screen
func show_game_over(instanciate: bool = true):
	speed = 0
	get_tree().current_scene.get_node("AudioStreamPlayer").playing = false
	if instanciate:
		get_tree().root.add_child(game_over.instantiate())


func retract_wall(stele_position: Vector2):
	retracted = true
	_max_retract = stele_position.x - retract_distance


func _fade_music():
	var distance = global_position.distance_to(player.global_position)
	# the closer, the louder (exponentially)
	if distance < music_fade_distance:
		audio_stream_player.volume_db = min(
			max_volume, -80 + volume_increase * (1 - distance / music_fade_distance)
		)
	else:
		audio_stream_player.volume_db = -80
