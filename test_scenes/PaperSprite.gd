extends Sprite2D

@export var loop_time = float(500)
var current_time
var distance
var indicator
var indicator_pos
var loop_percent
var loop_dir

var goal
var goal_y
var goal_range
@export var kindness = float(10)
var goal_limit_up
var goal_limit_down
# Called when the node enters the scene tree for the first time.

func _ready():
	current_time = float(0)
	distance = texture.get_height()
	indicator = $IndicatorSprite
	indicator_pos = indicator.get_position()
	loop_percent = float(0)
	loop_dir = 1 # 1 is down, -1 is up
	
	goal = $GoalSprite
	goal_y = goal.get_position().y
	goal_range = ((kindness / 2.0) / 100.0) * distance
	goal_limit_up = goal_y + goal_range
	goal_limit_down = goal_y - goal_range
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_released("dex_test"):
		_timing_press()
		
	current_time = current_time + loop_dir
	loop_percent = current_time / loop_time
	indicator.set_position(Vector2(indicator_pos.x, (loop_percent * distance) - (distance / 2)))
	indicator_pos = indicator.get_position()
	if current_time > loop_time or current_time < 0: 
		if loop_dir == 1:
			current_time = loop_time - 1
		else:
			current_time = 1
		loop_dir = loop_dir * -1
	pass
	
func _timing_press():
	if indicator_pos.y > goal_limit_down and indicator_pos.y < goal_limit_up:
		print("hit")
	else:
		print("miss")
	
