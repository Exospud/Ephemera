extends Panel


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_next_level()
	
	if Input.is_action_just_pressed("ui_cancel"):
		_quit_to_title()


## Initializes and plays the next available level
func _next_level():
	print("Not implemented yet :(")


## Renitializes and replays the last attempted level
func _retry_level():
	get_tree().change_scene("res://screens/play/PlayScreen.tscn")


## Sends the user back to the title screen
func _quit_to_title():
	get_tree().change_scene("res://screens/title/TitleScreen.tscn")
