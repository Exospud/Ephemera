class_name Tower
extends Deployable


const PL_PROJECTILE := preload("res://game/entities/projectiles/Projectile.tscn")

export var attack_delay := 1.0

onready var attack_timer = $AttackTimer


## TEMP: Fires the tower's weapon
func _use_ability():
	# Creates a new projectile
	var projectile := PL_PROJECTILE.instance()
	
	# Fire projectile and resets attack delay
	projectile.init(position, 0, alignment)
	_level.add_child(projectile)


## (OVERRIDE)
func on_turn_start():
	attack_timer.start(attack_delay)
	attack_timer.set_paused(false)


## (OVERRIDE)
func on_turn_end():
	attack_timer.set_paused(true)
