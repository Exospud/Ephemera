extends Control


const PL_UNIT_BUTTON := preload("res://assets/ui/imagebutton/UnitButton.tscn")


## Sets the GUI's unit buttons
func set_buttons(level: Level):
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()
	
	var margin_size = Vector2(20, 20)
	
	## Generating buttons according to units allowed in current level
	for i in range(0, level.spawnable.size()):
		var unit_button = PL_UNIT_BUTTON.instance()
		var spawn = Properties.unit_assets[level.spawnable[i]]
		unit_button.texture = spawn.texture
		unit_button.label_text = spawn.cost
		unit_button.spawn = level.spawnable[i]
		
		unit_button.anchor_right = 0.0
		unit_button.anchor_top = 1.0
		
		var button_size = unit_button.rect_size
		
		unit_button.margin_top = -margin_size.y - button_size.y
		unit_button.margin_bottom = -margin_size.y
		unit_button.margin_left = margin_size.x + i*(margin_size.x + button_size.x)
		unit_button.margin_right = (i+1)*(margin_size.x + button_size.x)
		
		add_child(unit_button)
