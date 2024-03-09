class_name Stele extends Area2D

var consumed = false

@onready var light: MyLight = $Light
@onready var animation: AnimatedSprite2D = $AnimatedSprite2D


func _on_body_entered(body: Node2D):
	var player = body as Player
	if not player or consumed:
		return

	consumed = true
	player.regen_light()
	light.visible = false
	animation.play("explosion")


func _on_animation_finished():
	if animation.animation.contains("explosion"):
		animation.play("dead")
