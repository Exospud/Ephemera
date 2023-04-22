extends Camera2D


export var scroll_speed: float = 250
export var init_stage_scale := 3.0

onready var _map : TileMap = $"../Map"
onready var _stage_scale := init_stage_scale

## Called when the node enters the scene tree for the first time.
func _ready():
	_reset_position()
	adjust_stage_scale(0)


## Called at a constant rate. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float):
	var scroll_dist := (scroll_speed * delta) / sqrt(_stage_scale)
	
	if Input.is_action_pressed("ui_left"):
		position.x -= scroll_dist
	
	if Input.is_action_pressed("ui_right"):
		position.x += scroll_dist
	
	if Input.is_action_pressed("ui_up"):
		position.y -= scroll_dist
	
	if Input.is_action_pressed("ui_down"):
		position.y += scroll_dist
	
	if Input.is_action_pressed("ui_zoom_in"):
		adjust_stage_scale(delta)
	
	if Input.is_action_pressed("ui_zoom_out"):
		adjust_stage_scale(-delta)
	
	if Input.is_key_pressed(KEY_R):
		_reset_position()


## Move the camera's view to the middle of the map
func _reset_position():
	var map_size = _map.cell_size * _map.get_used_rect().size
	position = map_size * 0.5;
	_stage_scale = init_stage_scale
	adjust_stage_scale(0)


## Increases or decreases the camera's zoom factor by the specified amount
func adjust_stage_scale(value: float):
	_stage_scale = clamp(_stage_scale + value, 1, 3)
	var zoom_factor := 1.0/_stage_scale;
	zoom = Vector2(zoom_factor, zoom_factor)
