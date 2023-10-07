extends Sprite2D

var loop_time
@export var loop_time_up = float(700)
@export var loop_time_down = float(100)
var current_time
var distance
var indicator
var indicator_pos
var loop_percent
var loop_dir

var goal
var goal_y
var goal_range
@export var kindness = float(20)
var goal_limit_up
var goal_limit_down

var next_press
var next_press_range
var rng

@export var miss_punish = 100
var miss_flag
var miss_time
# Called when the node enters the scene tree for the first time.

func _ready():
	rng = RandomNumberGenerator.new()
	loop_time = rng.randf_range(loop_time_down,loop_time_up)
	print(loop_time)
	
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
	
	set_rotation_degrees(rng.randf_range(0,360))
	
	next_press_range = [0,1]
	next_press = next_press_range[int(rng.randf_range(0, next_press_range.size()))]
	print(next_press)
	
	miss_flag = false
	miss_time = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if Input.is_action_just_released("dex_left"):
		_timing_press(0)
	elif Input.is_action_just_released("dex_right"):
		_timing_press(1)
		
	if miss_flag:
		print("miss")
		miss_time = miss_time + 1
		if miss_time > miss_punish:
			miss_flag = false
			miss_time = 0
	else:
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
	
func _timing_press(press):
	if indicator_pos.y > goal_limit_down and indicator_pos.y < goal_limit_up and press == next_press:
		print(press)
	else:
		miss_flag = true
	
