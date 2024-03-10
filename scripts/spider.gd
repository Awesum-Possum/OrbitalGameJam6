class_name Spider extends Area2D

@export var speed: float = 500

var _goes_down: bool = false
var _spawn_pos: Vector2
var _platform_pos: Vector2
var _over: bool = false

var _game_over = preload("res://game_over.tscn")


func _ready():
	body_entered.connect(_on_body_entered)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _goes_down and position.y < _platform_pos.y:
		position.y += speed * delta
	elif _goes_down and not _over and position.y >= _platform_pos.y:
		_goes_down = false
	elif position.y < _spawn_pos.y:
		position.y += speed * delta
	elif position.y > _spawn_pos.y:
		position.y -= speed * delta
	else:
		visible = false


## Makes the spider go down
## @param position: the position of where the spider should go down
func go_down(spawn, platform: Vector2):
	_goes_down = true
	_spawn_pos = spawn
	_platform_pos = platform
	position = spawn
	visible = true


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	Globals.game_over.emit()
	get_tree().create_timer(0.5).timeout.connect(
		func(): get_tree().root.add_child(_game_over.instantiate())
	)
	player.visible = false
	player.speed = 0
	_over = true
