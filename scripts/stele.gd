class_name Stele extends Area2D

## The white screen that will be displayed when the stele explodes
## The number of frames the white screen will be displayed
@export var white_screen_duration: int = 2

var _consumed = false
var _white_screen_countdown = 0

@onready var light: MyLight = $Light
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var white_screen: CanvasLayer = %WhiteScreen


func process(delta):
	if _white_screen_countdown > 0:
		_white_screen_countdown -= delta
		if _white_screen_countdown <= 0:
			light.turn_off()


func _on_body_entered(body: Node2D):
	var player = body as Player
	if not player or _consumed:
		return

	_consumed = true

	light.reset()
	# wait for light.decay_time to finish
	get_tree().create_timer(light.decay_time).timeout.connect(_start_explosion)


func _start_explosion():
	animation.play("explosion")


func _on_animation_finished():
	if animation.animation.contains("explosion"):
		_activate_white_screen()
		_white_screen_countdown = white_screen_duration
		animation.play("dead")


func _activate_white_screen():
	print("activate white screen")
	white_screen.show()
	white_screen.get_node("AnimationPlayer").play("fade_away")
