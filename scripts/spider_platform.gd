extends StaticBody2D

## The force applied to the player when jumping.
@export var stuck_force: float = 2
## The height from where the spider will fall.
@export var spider_height: int = 750

var spider_scene := preload("res://spider.tscn")
var _spawed_spider: Spider = null
@onready var _spider_pos: Vector2 = position - Vector2(0, spider_height)


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	player.stuck_force = stuck_force

	if _spawed_spider:
		_spawed_spider.go_down(_spider_pos, position)
		return

	_spawed_spider = spider_scene.instantiate()
	_spawed_spider.scale *= 4
	get_parent().call_deferred("add_child", _spawed_spider)
	_spawed_spider.go_down(_spider_pos, position)


func _on_body_exited(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	player.stuck_force = 0
