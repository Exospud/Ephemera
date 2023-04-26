extends Node

onready var _player := $AudioStreamPlayer

enum Tracks {TITLE, COMBAT}

const music_loops := {
	Tracks.TITLE: preload("res://assets/sounds/title.wav"),
	Tracks.COMBAT: preload("res://assets/sounds/combat.wav")
}


var current_track := -1
var _global_volume: float


# Called when the node enters the scene tree for the first time.
func _ready():
	set_audio_track(Tracks.TITLE)
	set_global_volume(0.3)


func set_audio_track(track: int):
	if current_track == track:
		return
	
	current_track = track
	_player.stream = music_loops[track]
	_player.play()


func get_global_volume():
	return _global_volume


func set_global_volume(value: float):
	_global_volume = value
	_player.volume_db = linear2db(value*value)
