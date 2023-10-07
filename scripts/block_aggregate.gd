extends Node2D


var blocks: Array[BlockBase]

@export var timer: Timer = null

# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
		if child is BlockBase:
			print("CHILD")
			blocks.append(child)
			(child as BlockBase).deactivate()
	
	if timer != null:
		timer.timeout.connect(activate_all)



func activate_all():
	for child in blocks:
		child.activate()
