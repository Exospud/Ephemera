class_name Unit extends Deployable


export var speed := 1.0 # tiles/second
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
		var slowed := false
		var hasted := false
		
		for entity in get_overlapping_areas():
			if entity.alignment == self.alignment:
				continue
			
			if entity.is_in_group("slowing"):
				slowed = true
			
			if entity.is_in_group("hasting"):
				hasted = true
		
		if _attack_targets.empty():
			var multiplier = 32
			if hasted:
				multiplier += 16
			if slowed:
				multiplier *= 0.5
			
			position.x += multiplier * speed * delta
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
func adjust_health(value: int):
	.adjust_health(value)
	
	if value < 0:
		sprite.self_modulate.a = 0.7
		$HurtTimer.start()


func _demodulate():
	sprite.self_modulate.a = 1.0


## (OVERRIDE)
func on_turn_end():
	on_death()
