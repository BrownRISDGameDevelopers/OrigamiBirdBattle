class_name StartMessage
extends Label

@export var messages: Array[String] = ["Ready...", "  Set...", "  Go!"]
var num_frames: int = 0
var message_num: int = 0
var last_num_frames: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	visible = true
	text = messages[message_num]
	
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
		
	
