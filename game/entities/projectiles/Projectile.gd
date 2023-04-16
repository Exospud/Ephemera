class_name Projectile
extends Entity


export var damage := 1
export var pierce := 1
export(Vector2) var velocity := Vector2.LEFT * 10 # tiles/second

onready var sprite := $Sprite


## Sets the projectile's initial values
func init(pos, rot, alignment):
	self.position = pos
	self.rotation = rot + PI/2
	self.alignment = alignment


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += 32 * velocity * delta
	_check_bounds()


## Checks for valid projectile collisions
func _collide(area):
	# Don't hit units of the same alignment
	if area.alignment == alignment: return
	
	# Don't hit healthless units (eg. other projectiles)
	if area.max_health <= 0: return
	
	# Prevent double-hits
	if pierce <= 0: return
	
	# otherwise, deal damage and delete the projectile if out of pierce
	area.adjust_health(-damage)
	pierce -= 1
	
	if pierce <= 0:
		on_death()


func _check_bounds():
	var despawn_buffer := 32
	var map_size = _map.cell_size * _map.get_used_rect().size
	
	if position.x < -despawn_buffer:
		on_death()
	if position.y < -despawn_buffer:
		on_death()
	if position.x > map_size.x + despawn_buffer:
		on_death()
	if position.y > map_size.y + despawn_buffer:
		on_death()
