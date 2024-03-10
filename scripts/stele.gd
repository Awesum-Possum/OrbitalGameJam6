class_name Stele extends Area2D

## The white screen that will be displayed when the stele explodes
## The number of frames the white screen will be displayed
@export var white_screen_duration: int = 2

var _consumed = false
var _to_explode = false
var _already_exploded = false
var _white_screen_countdown = 0

@onready var light: MyLight = $Light
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D
@onready var white_screen: CanvasLayer = %WhiteScreen
@onready var wall_of_death: WallOfDeath = %WallOfDeath


func _process(delta):
	if _white_screen_countdown > 0:
		_white_screen_countdown -= delta
		if _white_screen_countdown <= 0:
			light.reset()
			get_tree().create_timer(light.decay_time).timeout.connect(func(): _consumed = true)


func _on_body_entered(body: Node2D):
	var player = body as Player
	if not player or _to_explode:
		return

	_to_explode = true


func _start_explosion():
	animation.play("explosion")


func _on_animation_finished():
	if animation.animation.contains("default") and _to_explode and not _already_exploded:
		animation.play("explosion")
	elif animation.animation.contains("default") and _consumed:
		animation.play("consume")
	elif animation.animation.contains("consume"):
		light.turn_off()
		wall_of_death.retracted = false
	elif animation.animation.contains("explosion"):
		_already_exploded = true
		_activate_white_screen()
		_white_screen_countdown = white_screen_duration
		wall_of_death.retract_wall(position)
		animation.play("default")


func _activate_white_screen():
	print("activate white screen")
	white_screen.show()
	white_screen.get_node("AnimationPlayer").play("fade_away")
