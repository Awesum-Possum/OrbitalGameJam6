extends Area2D

class_name Stele

@onready var light = $Light

var consumed = false


func _on_body_entered(body:Node2D):
	if body.is_in_group("player") and not consumed:
		consumed = true
		body.regen_light()
		light.visible = false
