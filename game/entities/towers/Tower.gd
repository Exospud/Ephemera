class_name Tower extends Deployable


const PL_PROJECTILE := preload("res://game/entities/projectiles/Projectile.tscn")

export var attack_delay := 1.0

onready var _attack_timer = $AttackTimer


## TEMP: Fires the tower's weapon
func _use_ability():
	if not _has_target() or not _has_power():
		_attack_timer.start(0.1)
		return
	
	# Create a new projectile
	var projectile := PL_PROJECTILE.instance()
	
	# Fire projectile
	# TODO: replace with anchor system
	projectile.init(position + Vector2(-15, -5), 0, alignment)
	_level.add_child(projectile)
	_attack_timer.start(attack_delay)


## Returns true if there is a valid target for this tower to fire at
func _has_target() -> bool:
	for e in get_tree().get_nodes_in_group("entities"):
		# Ignore entities that cannot be hit
		if e.max_health <= 0:
			continue
		if e.alignment == self.alignment:
			continue
		
		# Shoot if entity is in tower's firing range
		var target_cell = _map.world_to_map(e.position)
		if target_cell.x > self.cell.x:
			continue
		if target_cell.y == self.cell.y:
			return true
	
	return false


func _has_power() -> bool:
	for e in get_tree().get_nodes_in_group("powered"):
		if abs(e.cell.x - cell.x) + abs(e.cell.y - cell.y) > 1:
			continue
		
		if e.is_in_group(str(alignment)):
			return true
	
	return false


## (OVERRIDE)
func on_turn_start():
	if attack_delay > 0:
		_attack_timer.start(attack_delay)
		_attack_timer.set_paused(false)


## (OVERRIDE)
func on_turn_end():
	_attack_timer.set_paused(true)
