extends Area2D

class_name Stele

@onready var light = $Light


func _on_body_entered(body:Node2D):
	print("Stele entered")
	if body.is_in_group("player"):
		body.regen_light()
		light.visible = false
