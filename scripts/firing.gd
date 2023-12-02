extends Node2D

@export var rotation_speed = 90
@export var rotation_min: float = -PI / 2
@export var rotation_max: float = 0
@export var rotation_dir: int = -1
@onready var needle = $needle
@onready var hand = $hand
@onready var pew1 = $FiringSound
@onready var pew2 = $FiringSound2
@onready var pew3 = $FiringSound3
@onready var pew4 = $FiringSound4
@onready var pew5 = $FiringSound5
@onready var pew6 = $FiringSound6
@onready var pew7 = $FiringSound7
@onready var pew8 = $FiringSound8
@onready var pew9 = $FiringSound9
@onready var pews = [pew1, pew2, pew3, pew4, pew5, pew6, pew7, pew8, pew9]

var launch_angle = 0
var start_firing = false



signal start_launch(angle)

func get_launch_angle():
	return launch_angle

func update_launch_angle(delta):
	if (launch_angle <= rotation_min):
		rotation_dir = 1
	if (launch_angle >= rotation_max):
		rotation_dir = -1
	launch_angle += delta * rotation_dir * rotation_speed * PI / 180
	launch_angle = clamp(launch_angle, rotation_min, rotation_max)

func rotate_needle():
	needle.set_rotation(launch_angle)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_firing:
		update_launch_angle(delta)
		rotate_needle()

func launch_bird():
	if start_firing:
		start_launch.emit(launch_angle)
		_play_firing_sound()
		_play_flick_anim()
		start_firing = false

func set_angle():
	start_firing = true
	launch_angle = 0
	
func _on_button_pressed():
	launch_bird()
	
func _on_button_2_pressed():
	set_angle()
	
func _play_firing_sound():
	var pew_index = randi()%9
	var pew = pews[pew_index]
	pew.play()
	await get_tree().create_timer(0.40).timeout
	pew.stop()
	
func _play_flick_anim():
	hand.play("flick")
	await get_tree().create_timer(0.45).timeout
	hand.stop()
	
	
	
