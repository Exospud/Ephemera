extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	$HSlider.value = Music.get_global_volume()


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


func _set_volume(value):
	Music.set_global_volume(value)
