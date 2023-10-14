extends Node2D
@onready var _arm = $arm
@onready var _fake_bird = $arm/fake_bird
@onready var _firing = $firing
@onready var _launch_reset_timer = $launch_reset_timer

@export var bird_scene: PackedScene
@export var force_magnitude = 2000
@export var launch_anim_duration_max = 0.2 # animation duration scales off of angle catapault moves
@export var time_per_shake = 0.3
@export var shake_delta_deg = 3

var arm_angle = 0
var shake_delta_acc = 0
var launch_delta_acc = 0
var launch_anim_duration = 0
var is_ready = false
var is_launching = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_ready && !is_launching:
		play_shake_anim(delta)
	elif is_launching:
		play_launch_anim(delta)
		if (launch_delta_acc >= launch_anim_duration):
			finish_launch()
			is_launching = false
			is_ready = false

func play_shake_anim(delta):
	shake_delta_acc += delta
	if shake_delta_acc >= time_per_shake:
		shake_delta_deg *= -1
		_arm.set_rotation(shake_delta_deg * PI / 180)
		shake_delta_acc = 0

func play_launch_anim(delta):
	if launch_delta_acc < launch_anim_duration:
		var arm_angle_delta = arm_angle * (delta / launch_anim_duration)
		_arm.set_rotation(_arm.get_rotation() + (arm_angle_delta * PI / 180))
		launch_delta_acc += delta

func _on_firing_start_launch(angle):
	is_launching = true
	arm_angle = angle * 180/PI + 90
	launch_delta_acc = 0
	launch_anim_duration = launch_anim_duration_max * (arm_angle / 90)

func finish_launch():
	_fake_bird.hide()
	var bird = bird_scene.instantiate()
	var bird_position = _fake_bird.global_position
	bird.position = Vector2(bird_position.x, bird_position.y)
	var launch_angle = _firing.get_launch_angle()
	var force_direction = Vector2(cos(launch_angle), sin(launch_angle))
	var force_vector = force_direction * force_magnitude
	bird.apply_central_impulse(force_vector)
	print(get_tree().get_root())
	get_tree().get_root().add_child(bird)
	_launch_reset_timer.start()

func _on_launch_reset_timer_timeout():
	_arm.set_rotation(0)
	is_ready = true
	_fake_bird.show()

func set_angle():
	_firing.set_angle()

func launch_bird():
	_firing.launch_bird()
