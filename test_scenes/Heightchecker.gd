extends Node2D

@export var testBody: RigidBody2D

var blocks: Array[RigidBody2D]
var highest: float

var count = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	count = 0
	print(testBody.get_shape.get_extents())
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_blocks(new_blocks):
	blocks = new_blocks

func _get_heights():
	for count in blocks.size():
		print("test")
	

func _check_height(block):
	pass
