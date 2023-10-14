extends Sprite2D

@export var loop_time = 100
var current_time
var distance
# Called when the node enters the scene tree for the first time.
func _ready():
	current_time = 0
	distance = "centered"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_time += 1
	
	pass
