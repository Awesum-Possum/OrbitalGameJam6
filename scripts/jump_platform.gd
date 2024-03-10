extends StaticBody2D

## The force applied to the player when jumping.
@export var jump_force = 1000

@onready var _audio: AudioStreamPlayer = $AudioStreamPlayer


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.jump(jump_force)
		_audio.play()
