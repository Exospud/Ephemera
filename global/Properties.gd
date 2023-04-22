extends Node

enum Levels {TEST_LEVEL, LEVEL_1, LEVEL_2, LEVEL_3}

## Dictionary of preloaded level assets
const level_assets = {
	Levels.TEST_LEVEL: preload("res://game/levels/TestLevel.tscn"),
	Levels.LEVEL_1: preload("res://game/levels/TestLevel.tscn"),
	Levels.LEVEL_2: preload("res://game/levels/TestLevel.tscn"),
	Levels.LEVEL_3: preload("res://game/levels/TestLevel.tscn")
}

var unlocked_levels := [Levels.TEST_LEVEL, Levels.LEVEL_1, Levels.LEVEL_2, Levels.LEVEL_3]
var current_level : int = -1


## Called when the node enters the scene tree for the first time.
func _ready():
	var s = Levels.TEST_LEVEL
	print(str(s))


## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
