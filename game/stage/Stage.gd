extends Node2D


onready var _map := $Map
onready var _level := $Level

onready var _turn_label : Label = $"../HUD/TurnLabel"
onready var _time_label : Label = $"../HUD/TimeLabel"
onready var _select_buttons := $"../HUD/SelectButtons"
onready var _end_timer : Timer = $EndTimer

var turn_number : int = 0
var time_elapsed : float = 0.0
var energy : int = 0
var setup_phase := false
var selected_unit : int = -1
var can_place := false


## Called when the node enters the scene tree for the first time.
func _ready():
	_select_buttons.set_buttons(_level)
	time_elapsed = _level.base_turn_duration
	_end_timer.set_paused(true)
	_end_turn()


## Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float):
	_update_time(delta)
	_check_groups()
	
	if Input.is_action_just_pressed("ui_select"):
		if setup_phase:
			_attempt_spawn()
	
	if Input.is_action_just_pressed("ui_accept"):
		_start_turn() if setup_phase else _end_turn()


# Check members of entity groups
func _check_groups():
	# The level is considered won if all towers are destroyed
	if get_tree().get_nodes_in_group(str(Entity.Alignment.ENEMY)).empty():
		_end_timer.set_paused(false)
	
	# End the current turn if no friendly units remain
	if get_tree().get_nodes_in_group(str(Entity.Alignment.FRIENDLY)).empty():
		_end_turn()


func _attempt_spawn():
	if not can_place:
		return
	
	if selected_unit < 0:
		return
		
	var cost : int = Level.spawn_assets[selected_unit].cost
	
	if energy < cost:
		return
	
	var mouse_cell : Vector2 = _map.get_mouse_cell()
	if _level.cell_available(mouse_cell) and mouse_cell.x < 5:
		_level.spawn_entity(mouse_cell, selected_unit)
		energy -= cost


## Updates time elapsed if the attacking phase is active
func _update_time(delta: float):
	var time_limit : float = _level.base_turn_duration
	
	if setup_phase:
		_time_label.text = "Phase: Setup"
		_time_label.text += "\nEnergy: " + str(energy)
	else:
		_time_label.text = "Phase: Attack"
		time_elapsed += delta
		if time_elapsed > time_limit:
			_end_turn()
		_time_label.text += "\nSeconds Left: " + str(ceil(time_limit - time_elapsed))


## If possible, ends the setup phase and starts the current turn
func _start_turn():
	if not setup_phase:
		return
	
	setup_phase = false
	
	for e in get_tree().get_nodes_in_group("entities"):
		e.on_turn_start()


## If possible, completes the current turn and advances the current game by one turn if possible
func _end_turn():
	if setup_phase:
		return
	
	for e in get_tree().get_nodes_in_group("entities"):
		e.on_turn_end()
		
	# The level is considered lost if the turn limit has been exceeded
	if turn_number >= _level.max_turns:
		_end_timer.set_paused(false)
		return
	
	var time_remaining := ceil(_level.base_turn_duration - time_elapsed)
	
	turn_number += 1
	setup_phase = true
	time_elapsed = 0.0
	energy = _level.base_energy_gen
	_turn_label.text = "Turn " + str(turn_number) + "/" + str(_level.max_turns)


func _end_game():
	if get_tree().get_nodes_in_group(str(Entity.Alignment.ENEMY)).empty():
		get_tree().change_scene("res://screens/win/WinScreen.tscn")
	else:
		get_tree().change_scene("res://screens/loss/LossScreen.tscn")
