class_name BlockBase extends RigidBody2D


@export var health: int = 5
@export var sturdiness: int = 3

@onready var health_node: Health = $Health
@onready var sprite: Sprite2D = $Sprite
@onready var active = true
@onready var speed = 500


var just_clicked: bool = false 

signal next_block()
# Called when the node enters the scene tree for the first time.
func _ready():
	mass = sturdiness
	health_node.set_max_health_and_health(health)



func _physics_process(delta):
	
	if (!just_clicked):
		stop()
	just_clicked = false 

	
#	if active:
#		if Input.is_action_pressed("player1_fold_left"):
#
#			left()
#		elif Input.is_action_pressed("player1_fold_right"):
#
#			right()
#		else:
#			stop()
		
	
func left():
	if active:
		self.linear_velocity.x = -speed
		just_clicked = true

func right():
	if active:		
		self.linear_velocity.x = speed	
		just_clicked = true
func stop():
	if active:
		self.linear_velocity.x = 0
func deactivate():
	set_process(false)
	freeze = true

func activate():
	set_process(true)
	freeze = false


func _on_body_entered(body):
	if active:
#		print("hi")
		active = false
		self.linear_velocity.x = 0
		next_block.emit()

