class_name BirdLauncher
extends Node2D
@onready var _arm = $arm
@onready var _fake_bird = $arm/fake_bird
@onready var _firing = $firing
@onready var _launch_reset_timer = $launch_reset_timer
@onready var _trajectory_line = $trajectory_line
#@onready var _hand = $hand

@export var bird_scene: PackedScene
@export var force_magnitude = 2000
@export var launch_anim_duration_max = 0.4
#@export var right_side: bool = false
@export var direction_multi: int = 1

var launch_delta_acc = 0
var launch_anim_duration = 0
var is_ready = false
var is_setting_angle = false
var is_launching = false

signal launched()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	_trajectory_line.set_begin_cap_mode(Line2D.LINE_CAP_ROUND)
	_trajectory_line.set_end_cap_mode(Line2D.LINE_CAP_ROUND)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_setting_angle:
		_trajectory_line.show()
		var launch_angle = _firing.get_launch_angle()
		var force_direction = Vector2(cos(launch_angle), direction_multi * sin(launch_angle))
		update_trajectory(_fake_bird.position, force_direction, force_magnitude, 0.01)
	else:
		_trajectory_line.hide()
	
#	_hand.hide()
	
	if is_ready && !is_launching:
		play_idle_anim(delta)		
	elif is_launching:
		play_launch_anim(delta)
		if (launch_delta_acc >= launch_anim_duration):
			finish_launch()
			is_launching = false
			is_ready = false

func play_idle_anim(delta):
	pass

func play_launch_anim(delta):
#	_hand.show()
	if launch_delta_acc < launch_anim_duration:
#		_hand.play("flick")
		launch_delta_acc += delta
		

func _on_firing_start_launch(angle):
	is_launching = true
	launch_delta_acc = 0
	launch_anim_duration = launch_anim_duration_max

func finish_launch():
	_fake_bird.hide()
	var bird = bird_scene.instantiate()
	var bird_position = _fake_bird.global_position
	bird.position = Vector2(bird_position.x, bird_position.y)
	var bird_sprite = bird.get_node("AnimatedSprite2D")
	bird_sprite.scale.x *= sign(direction_multi)
	var launch_angle = _firing.get_launch_angle()
	var force_direction = Vector2(cos(launch_angle), direction_multi * sin(launch_angle))
	var force_vector = direction_multi * force_direction * force_magnitude
	bird.apply_central_impulse(force_vector)
	get_tree().get_root().add_child(bird)
	_launch_reset_timer.start()
	
func update_trajectory(pos, dir, speed, delta):
	var max_points = 30
	var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
	_trajectory_line.clear_points()
	var vel = dir * speed
	vel.y *= direction_multi
	for i in range(max_points):
		_trajectory_line.add_point(pos)
		vel.y += gravity * delta
		pos += vel * delta
	
func _on_launch_reset_timer_timeout():
	is_ready = true
	_fake_bird.show()

func set_angle():
	_firing.set_angle()
	is_setting_angle = true

func launch_bird():
	is_setting_angle = false
	_firing.launch_bird()
	launched.emit()

func process_launching_input(launch_input):
	match launch_input:
		PlayerManager.LaunchingState.SETANGLE:
			set_angle()
		PlayerManager.LaunchingState.LAUNCH:
			launch_bird()
