extends Node2D
class_name Builder

@onready var conveyor = $conveyor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	

func drop_block():
	conveyor.pop_block()
	pass


func _on_conveyor_drop_block(blockdata):
	var block_drop = blockdata.block_shape.instantiate()
	block_drop.position = Vector2(462, 225)
	add_child(block_drop)
	pass # Replace with function body.
