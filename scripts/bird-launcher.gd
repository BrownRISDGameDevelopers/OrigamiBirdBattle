extends Node2D
@onready var _arm = $arm
@onready var _fake_bird = $arm/nest/fake_bird

var launch_angle = 0
var timestep = 0.3
var deltaAcc = 0
var shakeDeltaDeg = 3
var launch_anim_duration = 1

var isLaunching = false


# Called when the node enters the scene tree for the first time.
func _ready():
	_fake_bird.set_gravity_scale(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !isLaunching:
		playShakeAnim(delta)
	else:
		playLaunchAnim(delta)


func playShakeAnim(delta):
	deltaAcc += delta
	if deltaAcc >= timestep:
		shakeDeltaDeg *= -1
		_arm.set_rotation(shakeDeltaDeg * PI / 180)
		deltaAcc = 0

func playLaunchAnim(delta):
	var launch_angle_delta = launch_angle * (delta / launch_anim_duration)
	
	_arm.set_rotation(_arm.get_rotation() + launch_angle_delta)
	pass

func _on_firing_launched(angle):
	isLaunching = true
	launch_angle = 90 - angle
	deltaAcc = 0
