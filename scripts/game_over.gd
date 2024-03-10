extends CanvasLayer


func _ready():
	$Basso.play()
	await get_tree().create_timer(2.0).timeout
	$AudioStreamPlayer.play()


func _on_quit_pressed():
	get_tree().quit()


func _on_restart_pressed():
	queue_free()
	get_tree().reload_current_scene()
