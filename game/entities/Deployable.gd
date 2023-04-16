class_name Deployable
extends Entity


export var cell: Vector2


# Called when the node enters the scene tree for the first time.
func _ready():
	cell = cell.round();
	position = _map.map_to_world(cell) + _map.cell_size * 0.5
	self.add_to_group("placed")


## Returns the manhattan distance between this entity and the specified cell
func dist(cell: Vector2) -> int:
	var diff := cell - self.cell
	return int(abs(diff.x) + abs(diff.y))


## Sets the cell this entity is occupying, if possible
func set_cell(cell: Vector2):
	cell = cell.round()
	if _level.cell_available(cell):
		self.cell = cell;
		position = _map.map_to_world(cell) + _map.cell_size * 0.5
