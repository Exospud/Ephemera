class_name Entity
extends Area2D


enum Alignment { FRIENDLY, NEUTRAL, ENEMY }

export var max_health := 10 # set to <= 0 if entity cannot take damage
export(Alignment) var alignment := Alignment.NEUTRAL

onready var _health := max_health
onready var _level := get_parent()
onready var _stage := _level.get_parent()
onready var _map = $"../../Map"


## Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group(str(alignment))


## Increments or decrements entity health by the given value
func adjust_health(value: int):
	# Return if entity is invulnerable
	if max_health <= 0: return
	
	# Health should never go above max health or below zero
	_health = clamp(_health + value, 0, max_health)
	if _health == 0:
		on_death()


## Plays this entity's death sequence
func on_death():
	queue_free()
