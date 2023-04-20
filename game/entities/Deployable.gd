class_name Deployable
extends Entity


export var cell: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	cell = cell.round();
	position = _map.map_to_world(cell) + _map.cell_size * 0.5
	self.add_to_group("placed")


## Returns the manhattan distance between this entity and the specified cell
func dist(target: Vector2) -> int:
	var diff := target - self.cell
	return int(abs(diff.x) + abs(diff.y))


## Sets the cell this entity is occupying, if possible
func set_cell(target: Vector2):
	target = target.round()
	if _level.cell_available(target):
		self.cell = target;
		position = _map.map_to_world(target) + _map.cell_size * 0.5
