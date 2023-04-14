extends TileMap


## Returns the cell the user's mouse is currently hovering over
func get_mouse_cell() -> Vector2:
	return world_to_map(get_viewport().get_mouse_position() / 3)


## Returns true if a non-empty tile exists at the location of the specified cell
func is_valid_cell(cell: Vector2) -> bool:
	return get_cellv(cell) >= 0


## Returns true if the specified cell's coordinates are within the bounds of the level's map
func in_map_bounds(cell: Vector2) -> bool:
	return get_used_rect().has_point(cell)
