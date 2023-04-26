extends Node

onready var _player := $AudioStreamPlayer

enum Tracks {TITLE, COMBAT}

const music_loops := {
	Tracks.TITLE: preload("res://assets/sounds/title.wav"),
	Tracks.COMBAT: preload("res://assets/sounds/combat.wav")
}


var current_track := -1


# Called when the node enters the scene tree for the first time.
func _ready():
	set_audio_track(Tracks.TITLE)


func set_audio_track(track: int):
	if current_track == track:
		return
	
	current_track = track
	_player.stream = music_loops[track]
	_player.play()
