class_name FallingPlatform extends StaticBody2D
## The FallingPlatform is a platform that falls after a certain amount of time
## when the player steps on it.

## The time before the platform starts falling
@export var breaking_timer: float = 1.0
## The time before the platform is destroyed (after it starts falling)
@export var falling_timer: float = 10.0

var breaking: bool = false

@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var collider: CollisionShape2D = $Collider
@onready var area = $Area2D/CollisionShape2D
@onready var particles: GPUParticles2D = $Particles
@onready var _audio = $AudioStreamPlayer


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
		sprite.play("default")
		particles.emitting = true
		_audio.call_deferred("play")
		area.set_deferred("disabled", true)
		$Area2D.set_deferred("monitoring", false)
		get_tree().create_timer(breaking_timer).timeout.connect(break_fr)


func break_fr() -> void:
	breaking = false
	collider.disabled = true
	particles.emitting = false
	sprite.visible = false
	get_tree().create_timer(falling_timer).timeout.connect(queue_free)
