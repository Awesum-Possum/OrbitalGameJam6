class_name FallingPlatform extends RigidBody2D
## The FallingPlatform is a platform that falls after a certain amount of time
## when the player steps on it.

## The time before the platform starts falling
@export var breaking_timer: float = 1.0
## The time before the platform is destroyed (after it starts falling)
@export var falling_timer: float = 10.0

var breaking: bool = false


func _on_body_entered(body: Node2D) -> void:
	print("Body entered")
	print(body.name)
	if body is Player:
		break_platform()


## Call that function to initiate the breaking of the platform
func break_platform() -> void:
	print("Breaking platform")
	if not breaking:
		breaking = true
		get_tree().create_timer(breaking_timer).timeout.connect(func(): freeze = false)
