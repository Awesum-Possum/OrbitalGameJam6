extends StaticBody2D

## The force applied to the player when jumping.
@export var stuck_force: float = 2
## The height from where the spider will fall.
@export var spider_height: int = 750

var spider_scene := preload("res://spider.tscn")


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	player.stuck_force = stuck_force
	var spider: Spider = spider_scene.instantiate()
	spider.scale *= 4
	var spider_pos = position
	spider_pos.y -= spider_height
	get_parent().add_child(spider)
	spider.go_down(spider_pos, position)


func _on_body_exited(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	player.stuck_force = 0
