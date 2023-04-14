extends Node2D


onready var _map := $Map
onready var _tile_info : Label = $"../HUD/TileInfo"
onready var _turn_label : Label = $"../HUD/TurnLabel"
onready var _time_label : Label = $"../HUD/TimeLabel"


var turn_number := 0
var max_turns := 10 # TODO: replace
var time_elapsed := 0.0
var time_limit := 15 # TODO: replace

## Called when the node enters the scene tree for the first time.
func _ready():
	_next_turn()


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	_update_time(delta)
	_update_hover()
	
	if Input.is_action_just_pressed("ui_accept"):
		_next_turn()


func _update_time(delta: float):
	time_elapsed += delta
	_time_label.text = "Seconds Left: " + str(ceil(time_limit - time_elapsed))


## Updates game state info to match the cell the user is currently hovering over
func _update_hover():
	var mouse_cell = _map.get_mouse_cell()
	
	if _map.is_valid_cell(mouse_cell):
		var tileset_cell = _map.get_cell_autotile_coord(mouse_cell.x, mouse_cell.y);
		var tile_id = tileset_cell.y * 4 + tileset_cell.x
		_tile_info.text = str(mouse_cell) + ":" + str(tile_id)
	
	else:
		_tile_info.text = ""


## Advances the current game by one turn
func _next_turn():
	turn_number += 1
	time_elapsed = 0.0
	_turn_label.text = "Turn " + str(turn_number) + "/" + str(max_turns)
