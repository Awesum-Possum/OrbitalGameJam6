extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_body_entered(body : Node2D):
	var player = body as Player
	if not player:
		return
	
	# freeze player
	player.trigger_ending()
	
	# play monito
	$AudioStreamPlayer2D.play()
	
	# wait until you die
