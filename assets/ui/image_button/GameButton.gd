extends Button


enum SpriteGroup {PLAY, STOP, PAUSED}

export(SpriteGroup) var sprite_group

onready var _stage := $"/root/PlayScreen/Stage"


func _ready():
	_set_sprite(0, sprite_group)


func _set_sprite(var x: int, var y: int):
	$Sprite.region_rect.position.x = x*32
	$Sprite.region_rect.position.y = y*32


func _on_mouse_enter():
	_set_sprite(1, sprite_group)
	_stage.can_place = false


func _on_mouse_exit():
	_set_sprite(0, sprite_group)
	_stage.can_place = true


func _on_button_down():
	_set_sprite(2, sprite_group)


func _on_button_up():
	_set_sprite(1, sprite_group)
