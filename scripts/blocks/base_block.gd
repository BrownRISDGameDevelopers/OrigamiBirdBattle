class_name BlockBase extends RigidBody2D


@export var health: int = 5
@export var sturdiness: int = 3

@onready var health_node: Health = $Health
@onready var sprite: Sprite2D = $Sprite
@onready var active = true
@onready var speed = 500

@onready var audio: RandomAudio = $Audio

var origin_pos: Vector2
var x_range: float = 300
var just_clicked: bool = false 

var destroy_timer = -5

signal next_block()
# Called when the node enters the scene tree for the first time.
func _ready():
	mass = sturdiness
	health_node.set_max_health_and_health(health)

func _process(delta):
	
	# Logic to destroy block after being hit by bird
	if (destroy_timer > 0):
		destroy_timer -= delta
	if (destroy_timer > -2 and destroy_timer <= 0):
		queue_free()
	

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
		if ((global_position.x - (speed * (1/60))) > (origin_pos.x - x_range)): 
			self.linear_velocity.x = -speed
			just_clicked = true
		else:
			self.linear_velocity.x = 0

func right():
	if active:	
		if ((global_position.x + (speed * (1/60))) < (origin_pos.x + x_range)): 	
			self.linear_velocity.x = speed	
			just_clicked = true
		else: 
			self.linear_velocity.x = 0
			
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
	
	# Remove this line if we don't want it to be destroyed on break 
	if (body is BirdBase):
		print("BIRD BASE")
		destroy_timer = .05
			
	if active or destroy_timer > 0:
		print("BLOCK DONE")
		audio.play(randf_range(.9, 1.1))
		if (active):
			self.linear_velocity.x = 0
			next_block.emit()
		active = false
	else:
		pass
#		print("BODY ENTERED " + str(body.name))

