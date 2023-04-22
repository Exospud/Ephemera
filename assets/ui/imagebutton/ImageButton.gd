extends Button


export(Texture) var texture = preload("res://assets/missing.png")
export var label_text := "-1"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Texture.texture = self.texture
	$Label.text = self.label_text
