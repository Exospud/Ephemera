extends Tower


func _use_ability():
	var powered := _has_power()
	
	for entity in get_overlapping_areas():
		if entity.alignment == self.alignment:
			continue
		
		if powered:
			entity.adjust_health(-1)
	
	_attack_timer.start(attack_delay)


func _check_power_state():
	if _has_power():
		$Sprite.region_rect.position.x = 32
	else:
		$Sprite.region_rect.position.x = 0
