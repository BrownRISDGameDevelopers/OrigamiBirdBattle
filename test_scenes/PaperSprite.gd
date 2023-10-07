extends Sprite2D

@export var loop_time = float(500)
var current_time
var distance
var indicator
var indicator_pos
var loop_percent
var loop_dir
# Called when the node enters the scene tree for the first time.

func _ready():
	current_time = float(0)
	distance = texture.get_height()
	indicator = $IndicatorSprite
	indicator_pos = indicator.get_position()
	loop_percent = float(0)
	loop_dir = 1 # 1 is down, -1 is up
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
