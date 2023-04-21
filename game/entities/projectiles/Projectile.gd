class_name Projectile
extends Entity


export var damage := 1
export var pierce := 1
export var speed := 10


## Sets the projectile's initial values
func init(pos, rot, align):
	self.position = pos
	self.rotation = rot + PI*0.5
	self.alignment = align


## Called at a constant rate. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	position += 32 * speed * delta * Vector2.LEFT.rotated(rotation - PI*0.5)
	_check_bounds()


## Checks for valid projectile collisions
func _collide(entity: Entity):
	# Don't hit units of the same alignment
	if entity.alignment == alignment: return
	
	# Don't hit healthless units (eg. other projectiles)
	if entity.max_health <= 0: return
	
	# Prevent double-hits
	if pierce <= 0: return
	
	# otherwise, deal damage and delete the projectile if out of pierce
	entity.adjust_health(-damage)
	pierce -= 1
	
	if pierce <= 0:
		on_death()


## (OVERRIDE)
func on_turn_end():
	on_death()
