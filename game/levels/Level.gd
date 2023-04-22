class_name Level extends Node2D


export var max_turns := 10
export var base_turn_duration := 15
export var base_energy_gen := 5
export(Array, int) var spawnable = []

onready var _map := $"../Map"


## Returns true if this cell contains an entity
func has_entity(cell: Vector2) -> bool:
	return get_entity(cell) != null


## Returns true if a new unit can be placed on the specified cell
func cell_available(cell: Vector2) -> bool:
	return _map.is_valid_cell(cell) && not has_entity(cell)


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


## ABSTRACT
func on_clear():
	pass
