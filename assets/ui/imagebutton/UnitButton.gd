extends Button


export(Texture) var texture = preload("res://assets/missing.png")
export var label_text := ""
export(Level.Spawns) var spawn : int

onready var _stage := $"../../../Stage"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Texture.texture = self.texture
	$Label.text = self.label_text


func _set_selected_unit():
	for button in get_parent().get_children():
		button.pressed = false
	self.pressed = true
	
	_stage.selected_unit = spawn


func _on_mouse_enter():
	_stage.can_place = false


func _on_mouse_exit():
	_stage.can_place = true
