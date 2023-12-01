class_name RandomAudio
extends Node2D

@export var tracks: Array[AudioStream]
@onready var player: AudioStreamPlayer = $AudioStreamPlayer
@export var play_on_ready: bool

func _ready():
	if (play_on_ready):
		play()

func play(pitch = 1):
	
	player.pitch_scale = pitch
	if (tracks.size() > 0):
		player.stream = tracks[randi() % tracks.size()]
		player.play(0)
		
func stop():
	player.stop()
	

