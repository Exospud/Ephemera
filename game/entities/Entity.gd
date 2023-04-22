class_name Entity extends Area2D


enum Alignment { FRIENDLY, NEUTRAL, ENEMY }

export var max_health : int = 10 # set to <= 0 if entity cannot take damage
export(Alignment) var alignment := Alignment.NEUTRAL

onready var _health : int = max_health
onready var _level := get_parent()
onready var _stage := _level.get_parent()
onready var _map = $"../../Map"
onready var sprite : Sprite = $Sprite


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


func _check_bounds():
	var despawn_buffer := 16
	var map_size = _map.cell_size * _map.get_used_rect().size
	
	if position.x < -(sprite.texture.get_width() + despawn_buffer):
		on_death()
	if position.y < -(sprite.texture.get_height() + despawn_buffer):
		on_death()
	if position.x > map_size.x + sprite.texture.get_width() + despawn_buffer:
		on_death()
	if position.y > map_size.y + sprite.texture.get_height() + despawn_buffer:
		on_death()


## Defines the script executed by this entity when a turn starts
func on_turn_start():
	pass


## Defines the script executed by this entity when a turn ends
func on_turn_end():
	pass


## Plays this entity's death sequence
func on_death():
	queue_free()
