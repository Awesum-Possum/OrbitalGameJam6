extends StaticBody2D

## The force applied to the player when jumping.
@export var stuck_force: float = 2


func _on_body_entered(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	player.stuck_force = stuck_force


func _on_body_exited(body: Node2D) -> void:
	var player = body as Player
	if not player:
		return

	player.stuck_force = 0
