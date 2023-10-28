extends Node2D


var blocks: Array[BlockBase]

@export var timer: Timer = null
signal block_freed()
# Called when the node enters the scene tree for the first time.
func _ready():
	
	for child in get_children():
		if child is BlockBase:
			print("CHILD")
			blocks.append(child)
			(child as BlockBase).deactivate()
	
	if timer != null:
		timer.timeout.connect(activate)
	activate()



func activate():
	for child in blocks:
		child.activate()

func deactivate():
	for child in blocks:
		child.deactivate()
