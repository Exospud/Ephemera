class_name Unit extends Deployable


export(Vector2) var velocity := Vector2.RIGHT # tiles/second
export var attack_damage := 1
export var attack_delay := 0.5

var _attack_targets = []

onready var _sprite := $Sprite
onready var _attack_timer := $AttackTimer


## Called when the node enters the scene tree for the first time.
func _ready():
	_sprite.position += Vector2(randi() % 5 - 2, randi() % 9 - 4)


## Called at a constant rate. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if not _stage.setup_phase:
		if _attack_targets.empty():
			position += 32 * velocity * delta
			_check_bounds()


## Checks for valid attack targets
func _on_area_enter(entity: Entity):
	# Don't attack units of the same alignment
	if entity.alignment == alignment: return
	
	# Don't attack healthless units (eg. other projectiles)
	if entity.max_health <= 0: return
	
	_attack_targets.append(entity)
	
	if _attack_timer.is_stopped():
		_attack()


## Remove target from attack targets if possible
func _on_area_exit(entity: Entity):
	_attack_targets.erase(entity)


## Attacks a target in range if one can be found
func _attack():
	if _attack_targets.empty():
		return
	
	_attack_targets[0].adjust_health(-attack_damage)
	_attack_timer.start(attack_delay)


## (OVERRIDE)
func on_turn_end():
	on_death()
