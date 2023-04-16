class_name Tower
extends Deployable


const PL_PROJECTILE := preload("res://game/entities/projectiles/Projectile.tscn")

export var attack_delay := 1.0

onready var attack_timer := $AttackTimer


## TEMP: Fires the tower's weapon
func _use_ability():
	if _stage.setup_phase:
		return
	
	# Creates a new projectile
	var projectile := PL_PROJECTILE.instance()
	
	# Fire projectile and resets attack delay
	projectile.init(position, 0, alignment)
	_level.add_child(projectile)
	attack_timer.start(attack_delay)
