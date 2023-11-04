extends Label

@export var timer: Timer 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if timer and timer.is_stopped() == false:
		var time_left = timer.time_left
		#need to floor it it's being weird tho
		text = str(time_left) # str(time_left)
	pass
