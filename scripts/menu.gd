extends Control
@onready var main = $MarginContainer/Main
@onready var credits = $MarginContainer/Credits

# Called when the node enters the scene tree for the first time.
func _ready():
	credits.hide()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# start game
func _on_run_pressed():
	get_tree().change_scene_to_file('res://initial_scene.tscn')

# pass to credits scene
func _on_credits_pressed():
	show_and_hide(credits, main)

# Quit game
func _on_quit_pressed():
	get_tree().quit() 
	

func _on_back_pressed():
	show_and_hide(main, credits)

func show_and_hide(first, second):
	first.show()
	second.hide()
