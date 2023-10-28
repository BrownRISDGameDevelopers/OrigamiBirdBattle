extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _get_steps():
	var steps = []
	for i in self.get_children ():
		steps.append(i)
	return steps

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
