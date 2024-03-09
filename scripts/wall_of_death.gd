extends Area2D


@export var speed = 400
@export var player: Node2D = null

var game_over = preload('res://game_over.tscn')

@onready var dogs = $Dogs


func _process(delta):
	position.x += speed * delta
	dogs.move(player.position.y)


func _on_body_entered(body:Node2D):
	if body is Player:
		Globals.game_over.emit()
		speed = 3000
		get_tree().create_timer(0.5)\
			.timeout.connect(show_game_over)

func show_game_over():
	speed = 0
	get_tree().root.add_child(game_over.instantiate())
