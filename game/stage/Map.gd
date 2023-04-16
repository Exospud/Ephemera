extends TileMap


onready var _camera : Camera2D = $"../Camera"
onready var _tile_info : Label = $"../../HUD/TileInfo"
onready var _tile_hover := $TileHover


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	_update_hover()


## Updates game state info to match the cell the user is currently hovering over
func _update_hover():
	var mouse_cell = get_mouse_cell()
	_set_tile_hover(mouse_cell)
	
	if is_valid_cell(mouse_cell):
		var tileset_cell = get_cell_autotile_coord(mouse_cell.x, mouse_cell.y);
		var tile_id = tileset_cell.y * 4 + tileset_cell.x
		_tile_info.text = str(mouse_cell) + ":" + str(tile_id)
	
	else:
		_tile_info.text = ""


## Moves the tile hover to the given cell, and sets visibility accordingly
func _set_tile_hover(cell: Vector2):
	_tile_hover.visible = is_valid_cell(cell)
	_tile_hover.position = map_to_world(cell)


## Returns the cell the user's mouse is currently hovering over
func get_mouse_cell() -> Vector2:
	var camera_position = _camera.get_camera_position()
	var mouse_position = get_viewport().get_mouse_position()
	var mouse_offset = (mouse_position - get_viewport().size * 0.5) * _camera.zoom
	return world_to_map(camera_position + mouse_offset)


## Returns true if a non-empty tile exists at the location of the specified cell
func is_valid_cell(cell: Vector2) -> bool:
	return get_cellv(cell) >= 0


## Returns true if the specified cell's coordinates are within the bounds of the level's map
func in_map_bounds(cell: Vector2) -> bool:
	return get_used_rect().has_point(cell)
