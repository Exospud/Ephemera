extends Unit


## Attacks a target in range if one can be found
func _attack():
	if _attack_targets.empty():
		return
	
	# Deal double damage to barricades
	if _attack_targets[0].is_in_group("barricades"):
		_attack_targets[0].adjust_health(-attack_damage*2)
	else:
		_attack_targets[0].adjust_health(-attack_damage)
	
	_attack_timer.start(attack_delay)
