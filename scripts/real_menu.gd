extends CanvasLayer

@onready var main = $Control/PanelContainer/MarginContainer/VBoxContainer
@onready var credits = $Control/PanelContainer/MarginContainer/Credits


func _on_run_pressed():
	get_tree().change_scene_to_file(Globals.MAIN_SCENE_PATH)


func _on_credits_pressed():
	show_and_hide(credits, main)


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	show_and_hide(main, credits)


func show_and_hide(first, second):
	first.show()
	second.hide()
