extends Button


export var level : int


func _start_level():
	Properties.current_level = self.level
	get_tree().change_scene("res://screens/play/PlayScreen.tscn")
