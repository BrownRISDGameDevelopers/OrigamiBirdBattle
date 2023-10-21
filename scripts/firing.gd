extends Node2D

@export var rotation_speed = 90
@export var rotation_min: float = -PI / 2
@export var rotation_max: float = 0
@export var rotation_dir: int = -1
@onready var needle = $needle
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

func _on_button_pressed():
	launch_bird()
	
func _on_button_2_pressed():
	set_angle()

func launch_bird():
	if start_firing:
		start_launch.emit(launch_angle)
		start_firing = false

func set_angle():
	start_firing = true
	launch_angle = 0
