extends Node2D


onready var _map := $Map
onready var _level := $Level

onready var _turn_label : Label = $"../HUD/TurnLabel"
onready var _time_label : Label = $"../HUD/TimeLabel"

var turn_number := 0
var time_elapsed := 0.0
var setup_phase := true


## Called when the node enters the scene tree for the first time.
func _ready():
	_end_turn()


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	_update_time(delta)
	
	if Input.is_action_just_pressed("ui_accept"):
		_start_turn() if setup_phase else _end_turn()
	
	if Input.is_action_just_pressed("ui_select"):
		if setup_phase:
			var mouse_cell = _map.get_mouse_cell()
			if _map.is_valid_cell(mouse_cell):
				_level.spawn_entity(mouse_cell)


## Updates time elapsed if the attacking phase is active
func _update_time(delta: float):
	var time_limit : float = _level.base_turn_duration
	
	if setup_phase:
		_time_label.text = "Phase: Setup"
	else:
		_time_label.text = "Phase: Attack"
		time_elapsed += delta
		if time_elapsed > time_limit:
			_end_turn()
	
	_time_label.text += "\nSeconds Left: " + str(ceil(time_limit - time_elapsed))


## Ends the setup phase and starts the current turn
func _start_turn():
	setup_phase = false
	
	for e in get_tree().get_nodes_in_group("entities"):
		e.on_turn_start()


## Completes the current turn and advances the current game by one turn if possible
func _end_turn():
	for e in get_tree().get_nodes_in_group("entities"):
		e.on_turn_end()
	
	# The level is considered won if all towers are destroyed
	if get_tree().get_nodes_in_group(str(Entity.Alignment.ENEMY)).empty():
		get_tree().change_scene("res://screens/win/WinScreen.tscn")
		return
	
	turn_number += 1
	
	# The level is considered lost if the turn limit has been exceeded
	if turn_number > _level.max_turns:
		get_tree().change_scene("res://screens/loss/LossScreen.tscn")
	
	setup_phase = true
	time_elapsed = 0.0
	_turn_label.text = "Turn " + str(turn_number) + "/" + str(_level.max_turns)
