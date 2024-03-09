extends RigidBody2D

class_name FallingPlatform

# The time before the platform starts falling
@export var breaking_timer: float = 1.0
# The time before the platform is destroyed (after it starts falling)
@export var falling_timer: float = 10.0

var breaking: bool = false

func _ready():
    connect("body_entered", _on_body_entered)

func _on_body_entered(body: Node) -> void:
  if body.is_in_group("player"):
    break_platform()


# Call that function to initiate the breaking of the platform
func break_platform() -> void:
  if not breaking:
    breaking = true
    get_tree()\
      .create_timer(breaking_timer)\
      .timeout.connect(func(): freeze = false)



