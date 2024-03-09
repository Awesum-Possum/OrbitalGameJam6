extends CanvasLayer


func _on_quit_pressed():
	get_tree().quit()

func _on_restart_pressed():
	queue_free()
	get_tree().reload_current_scene()

