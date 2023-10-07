extends Node2D

@export var rotation_speed = 90
@export var bird_scene: PackedScene
@onready var needle = $needle
var launch_angle = 0
var rotation_min = -PI / 2
var rotation_max = 0
var rotation_dir = -1
var force_magnitude = 2000
var start_firing = false

func rotateNeedle(delta):
	if (launch_angle <= rotation_min):
		rotation_dir = 1
	if (launch_angle >= rotation_max):
		rotation_dir = -1
	launch_angle += delta * rotation_dir * rotation_speed * PI / 180
	launch_angle = clamp(launch_angle, rotation_min, rotation_max)
	needle.set_rotation(launch_angle)
	
func launch():
	var bird = bird_scene.instantiate()
	var force_direction = Vector2(cos(launch_angle), sin(launch_angle))
	var force_vector = force_direction * force_magnitude
	bird.apply_central_impulse(force_vector)
	add_child(bird)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if start_firing:
		rotateNeedle(delta)

func _on_button_pressed():
	if start_firing:
		launch()
		start_firing = false

func _on_button_2_pressed():
	start_firing = true
