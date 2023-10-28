extends Node2D

@export var block_array: Array[RigidBody2D]

# Called when the node enters the scene tree for the first time.
func _ready():
	$Heightchecker._get_blocks(block_array)
	$Heightchecker._get_heights()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
