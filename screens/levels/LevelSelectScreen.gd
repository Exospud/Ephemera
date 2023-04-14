extends Panel


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_quit_to_title()


## Initializes and plays the specified level
func _start_level():
	# TODO: initialize level
	get_tree().change_scene("res://screens/play/PlayScreen.tscn")


## Sends the user back to the title screen
func _quit_to_title():
	get_tree().change_scene("res://screens/title/TitleScreen.tscn")
