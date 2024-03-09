extends Area2D

## The force applied to the player when jumping.
@export var jump_force = 1000


func _on_body_entered(body: Node2D) -> void:
	print("JUMP!")
	if body is Player:
		body.jump(jump_force)
