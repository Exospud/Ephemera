class_name Level extends Node2D


enum Units {SNIDER, SNASER, ROCKMITE} ## Enum exports broken lol, copy from Properties.Units

export var max_turns := 10
export var base_turn_duration := 15
export var base_energy_gen := 5
export var spawn_area_width := 3
export(Array, Units) var spawnable = [Units.SNIDER]

onready var _map := $"../Map"


## Called when the node enters the scene tree for the first time.
func _ready():
	for entity in get_children():
		entity.set_cell(entity.cell)


## Returns true if this cell contains an entity
func has_entity(cell: Vector2) -> bool:
	return get_entity(cell) != null


## Returns true if a new unit can be placed on the specified cell
func cell_available(cell: Vector2) -> bool:
	return _map.is_valid_cell(cell) and not has_entity(cell)


## Returns the entity occupying this cell, or null if there is none
func get_entity(cell: Vector2) -> Node2D:
	if _map.in_map_bounds(cell):
		for e in get_tree().get_nodes_in_group("placed"):
			if e.cell.is_equal_approx(cell):
				return e
	
	return null


#$ Spawns an entity at the specified cell if possible
func spawn_entity(cell: Vector2, unit: int):
	if cell_available(cell):
		var entity : Entity = Properties.unit_assets[unit].scene.instance()
		add_child(entity)
		entity.set_cell(cell)
