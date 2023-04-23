extends Control


const PL_UNIT_BUTTON := preload("res://assets/ui/image_button/UnitButton.tscn")
const PL_INTRO_SLIDE := preload("res://assets/ui/intro_slide/IntroSlide.tscn")


func clear_children():
	for child in self.get_children():
		self.remove_child(child)
		child.queue_free()


## Sets the GUI's unit buttons
func set_buttons(level: Level):	
	var margin_size = Vector2(20, 20)
	
	## Generating buttons according to units allowed in current level
	for i in range(0, level.spawnable.size()):
		var unit_button := PL_UNIT_BUTTON.instance()
		var spawn = Properties.unit_assets[level.spawnable[i]]
		unit_button.texture = spawn.texture
		unit_button.label_text = spawn.cost
		unit_button.spawn = level.spawnable[i]
		
		var button_size = unit_button.rect_size
		
		unit_button.margin_top = -margin_size.y - button_size.y
		unit_button.margin_bottom = -margin_size.y
		unit_button.margin_left = margin_size.x + i*(margin_size.x + button_size.x)
		unit_button.margin_right = (i+1)*(margin_size.x + button_size.x)
		
		add_child(unit_button)


func set_intro_slides(unlocks):
	var i := 0
	var margin_y := 25
	
	for j in range(0, unlocks.units.size()):
		var intro_slide := PL_INTRO_SLIDE.instance()
		var unit = Properties.unit_assets[unlocks.units[j]]
		
		intro_slide.texture = unit.texture
		intro_slide.label_text = unit.name + ": " + unit.desc
		
		var slide_size = intro_slide.rect_size
		intro_slide.margin_top = i*(margin_y + slide_size.y)
		intro_slide.margin_bottom = slide_size.y + i*(margin_y + slide_size.y)
		
		add_child(intro_slide)
		
		i += 1
	
	for j in range(0, unlocks.towers.size()):
		var intro_slide := PL_INTRO_SLIDE.instance()
		var tower = Properties.tower_assets[unlocks.towers[j]]
		
		intro_slide.texture = tower.texture
		intro_slide.label_text = tower.name + ": " + tower.desc
		
		var slide_size = intro_slide.rect_size
		intro_slide.margin_top = i*(margin_y + slide_size.y)
		intro_slide.margin_bottom = slide_size.y + i*(margin_y + slide_size.y)
		
		add_child(intro_slide)
		
		i += 1
