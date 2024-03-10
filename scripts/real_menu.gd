extends CanvasLayer

@onready var main = $Control/PanelContainer/MarginContainer/VBoxContainer
@onready var credits = $Control/PanelContainer/MarginContainer/Credits

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_run_pressed():
	get_tree().change_scene_to_file("res://initial_scene.tscn")


func _on_credits_pressed():
	show_and_hide(credits, main)


func _on_quit_pressed():
	get_tree().quit()


func _on_back_pressed():
	show_and_hide(main, credits)

func show_and_hide(first, second):
	first.show()
	second.hide()
