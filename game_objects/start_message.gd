class_name StartMessage
extends Label

var messages = ["Ready...", "  Set...", "  Go!"]
var num_frames
var message_num
var last_num_frames

# Called when the node enters the scene tree for the first time.
func _ready():
	num_frames = 0
	last_num_frames = 0
	message_num = 0
	visible = true
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	num_frames = num_frames + 1
	if num_frames == last_num_frames + 100 && message_num < 3:
		text = messages[message_num]
		message_num = message_num + 1
		last_num_frames = num_frames
	if num_frames == 450:
		visible = false
		set_process(false)
		
	
