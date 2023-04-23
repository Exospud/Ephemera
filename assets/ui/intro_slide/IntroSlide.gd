extends Button


export(Texture) var texture = preload("res://assets/missing.png")
export var label_text := ""
export var despawn_time := 30

onready var _stage := $"../../../Stage"


# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureRect.texture = self.texture
	$Label.text = self.label_text
	$DespawnTimer.start(despawn_time)


func _on_mouse_enter():
	_stage.can_place = false


func _on_mouse_exit():
	_stage.can_place = true
