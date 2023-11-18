class_name CheckHeight
extends Node2D
var velocity
var wait_time = .75
@export var screen_height = 1080 

var done: bool = false

signal height_found(height)

# Called when the node enters the scene tree for the first time.
func _ready():
	# Start velocity at 0
	velocity = 0
	done = false

# Change the velocity to 30 once the game has ended so that the line moves down
func game_end():
	velocity = 30
	done = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	if (velocity > 0):
		if (wait_time <= 0):
			# Don't move the line until the game has ended
			global_position += Vector2(0, velocity)
		else:
			wait_time -= delta

# Return the height (total height minus distance between tower and top) 
func get_height():
	return screen_height - global_position.y 

# When we collide with a player's tower, stop the velocity
func _on_area_2d_body_entered(body):
	velocity = 0
	
	if (done == false):
		height_found.emit(global_position.y)
		done = true

# Resets the height (at the start of a new game, for example)
# TODO: Subscribe to a start_game kind of method?
func reset_height():
	velocity = 0
	position.y = 0
