extends Control


const PL_IMAGE_BUTTON := preload("res://assets/ui/imagebutton/ImageButton.tscn")


## Sets the GUI's unit buttons
func set_buttons(level: Level):
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()
	
	var margin_size = Vector2(20, 20)
	
	## Generating buttons according to units allowed in current level
	for i in range(0, level.spawnable.size()):
		var image_button = PL_IMAGE_BUTTON.instance()
		var spawn = level.spawn_assets[level.spawnable[i]]
		image_button.texture = spawn.texture
		image_button.label_text = spawn.cost
		image_button.anchor_right = 0.0
		image_button.anchor_top = 1.0
		
		var button_size = image_button.rect_size
		
		image_button.margin_bottom = -margin_size.y
		image_button.margin_left = margin_size.x + i*(margin_size.x + button_size.x)
		image_button.margin_top = -margin_size.y - button_size.y
		image_button.margin_right = margin_size.x + button_size.x + i*(margin_size.x + button_size.x)
		
		add_child(image_button)
