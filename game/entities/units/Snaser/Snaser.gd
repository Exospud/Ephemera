extends Unit


const PL_PROJECTILE := preload("res://game/entities/projectiles/Projectile.tscn")

export var ability_delay := 1.0

onready var _ability_timer = $AbilityTimer


# TEMP: Fires the unit's weapon
func _use_ability():
	# Create a new projectile
	var projectile := PL_PROJECTILE.instance()
	
	# Fire projectile and resets attack delay
	projectile.init(position + sprite.position, PI, alignment)
	_level.add_child(projectile)


## Defines the script executed by this entity when a turn starts
func on_turn_start():
	_ability_timer.start(ability_delay)
