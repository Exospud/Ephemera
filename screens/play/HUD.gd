extends CanvasLayer


onready var _stage := $"../Stage"


func _toggle_pause():
	$PauseMenu.toggle_pause()


func _on_play_pressed():
	_stage.start_turn()


func _on_stop_pressed():
	_stage.end_turn()
