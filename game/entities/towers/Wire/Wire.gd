extends Tower


## (OVERRIDE)
func _use_ability():
	if not _has_power() or not _has_target():
		_attack_timer.start(0.1)
		return
	
	for entity in get_overlapping_areas():
		if entity.alignment != self.alignment:
			entity.adjust_health(-1)
	
	_attack_timer.start(attack_delay)


## (OVERRIDE)
func _has_target() -> bool:
	return get_overlapping_areas().size() > 0


func _check_power_state():
	if _has_power():
		$Sprite.region_rect.position.x = 32
	else:
		$Sprite.region_rect.position.x = 0
