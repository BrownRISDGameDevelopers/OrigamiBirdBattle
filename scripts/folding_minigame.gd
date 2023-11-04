class_name FoldingMinigame
extends Sprite2D

var go_flag

var repeat_count

signal finish()

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
var kindness
@export var base_kindness = float(80)
var goal_limit_up
var goal_limit_down

var next_press
var next_press_range
var rng

@export var miss_punish = 100
var miss_flag
var miss_time

@onready var arrows: Node2D = $arrows
var arrows_array 
var arrows_position: Transform2D

var steps

# Called when the node enters the scene tree for the first time.

func _ready():
	go_flag = false
	
	arrows_array = [$arrows/downSprite, $arrows/upSprite, $arrows/leftSprite, $arrows/rightSprite]
	arrows_position = arrows.get_global_transform()
	
	steps = $steps._get_steps()
	
	rng = RandomNumberGenerator.new()
	
	distance = texture.get_height() - 70
	indicator = $IndicatorSprite
	indicator_pos = indicator.get_position()
	
	goal = $GoalSprite
	
	next_press_range = [0,1,2,3]
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if go_flag:
#		if Input.is_action_just_released("fold_down"):
#			_timing_press(0)
#		elif Input.is_action_just_released("fold_up"):
#			_timing_press(1)
#		elif Input.is_action_just_released("fold_left"):
#			_timing_press(2)
#		elif Input.is_action_just_released("fold_right"):
#			_timing_press(3)
			
		if miss_flag:
#			print("miss")
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
	
func start_rounds(num):
	repeat_count = num
	print("minigame s")
	_start_game()
	
func _start_game():
	loop_time = rng.randf_range(loop_time_down,loop_time_up)
	print(loop_time)
	
	kindness = base_kindness - (loop_time / 8)
	
	for i in steps:
		i.visible = false
	
	steps[repeat_count].visible = true
	
	current_time = randf_range(0, 50)
	loop_percent = randf_range(0, 50)
	loop_dir = 1 # 1 is down, -1 is up
	
	goal_y = goal.get_position().y
	goal_range = ((kindness / 2.0) / 100.0) * distance
	goal_limit_up = goal_y + goal_range
	goal_limit_down = goal_y - goal_range
	
	set_rotation_degrees(rng.randf_range(0,360))
	
	next_press = next_press_range[int(rng.randf_range(0, next_press_range.size()))]
	arrows_array[next_press].visible = true
	
	miss_flag = false
	miss_time = 0
	
	go_flag = true
	
	arrows.set_global_transform(arrows_position)
	
func _timing_press(press):
	if indicator_pos.y > goal_limit_down and indicator_pos.y < goal_limit_up: 
#	and press == next_press:
		for i in arrows_array:
			i.visible = false
		if repeat_count > 0:
			repeat_count = repeat_count - 1
			_start_game()
		else:
			finish.emit()
	else:
		miss_flag = true
	
