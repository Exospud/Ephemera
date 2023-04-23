extends Panel


const PL_LEVEL_BUTTON := preload("res://assets/ui/text_button/LevelButton.tscn")


# Called when the node enters the scene tree for the first time.
func _ready():
	var margin_size := Vector2(30, 20)
	
	for i in range(0, Properties.unlocked_levels.size()):
		var level_button := PL_LEVEL_BUTTON.instance()
		level_button.level = Properties.unlocked_levels[i]
		level_button.text = str(Properties.unlocked_levels[i] + 1)
		
		level_button.anchor_top = 0.15
		level_button.anchor_left = 0.05
		
		var button_size = level_button.rect_size
		
		level_button.margin_top = margin_size.y
		level_button.margin_bottom = margin_size.y + button_size.y
		level_button.margin_left = margin_size.x + i*(margin_size.x + button_size.x)
		level_button.margin_right = (i+1)*(margin_size.x + button_size.x)
		
		add_child(level_button)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		_quit_to_title()


## Sends the user back to the title screen
func _quit_to_title():
	get_tree().change_scene("res://screens/title/TitleScreen.tscn")
