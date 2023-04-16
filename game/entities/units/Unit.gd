class_name Unit
extends Deployable


export(Vector2) var velocity := Vector2.RIGHT # tiles/second
export var attack_damage := 1
export var attack_rate := 1

onready var sprite := $Sprite


## Called when the node enters the scene tree for the first time.
func _ready():
	sprite.position += Vector2(randi() % 5 - 2, randi() % 9 - 4)


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not _stage.setup_phase:
		position += 32 * velocity * delta
