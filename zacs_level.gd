extends Node2D



var flash_count = 0

@onready var second_part = $SecondPart

# Called when the node enters the scene tree for the first time.
func _ready():
	second_part.visible = false
	Globals.flash.connect(first_flash)

func first_flash():
	flash_count += 1
	if flash_count == 1:
		second_part.visible = true
	
	elif flash_count == 4:
		print("Switch to next level")
