extends Panel


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_retry_level()
	
	if Input.is_action_just_pressed("ui_cancel"):
		_quit_to_title()


## Renitializes and replays the last attempted level
func _retry_level():
	get_tree().change_scene("res://screens/play/PlayScreen.tscn")


## Sends the user back to the title screen
func _quit_to_title():
	get_tree().change_scene("res://screens/select/LevelSelectScreen.tscn")
