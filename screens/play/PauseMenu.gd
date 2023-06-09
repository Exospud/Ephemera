extends ColorRect


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		toggle_pause()


## Toggles the pause state of the game and the visibility of the pause modal
func toggle_pause():
	get_tree().paused = not get_tree().paused
	visible = get_tree().paused


## Resets all progress and unpauses the game
func _reset_stage():
	toggle_pause()
	get_tree().reload_current_scene()


## Quits the game and returns to the title screen
func _to_title():
	toggle_pause()
	get_tree().change_scene("res://screens/select/LevelSelectScreen.tscn")
