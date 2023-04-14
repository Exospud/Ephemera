extends Panel


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		_to_level_select()
	
	if Input.is_action_just_pressed("ui_cancel"):
		_exit()


## Sends the user to the level select screen
func _to_level_select():
	get_tree().change_scene("res://screens/select/LevelSelectScreen.tscn")


## Terminates the application
func _exit():
	get_tree().quit()
