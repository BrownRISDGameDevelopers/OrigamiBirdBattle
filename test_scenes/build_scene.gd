extends Node2D
class_name Builder

@onready var conveyor: Conveyor = $conveyor
@export var to_parent: Node2D
@export var spawn_pos: Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	if (to_parent == null):
		to_parent = get_parent()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	pass
	

func drop_block():
	conveyor.pop_block()
	pass


func _on_conveyor_drop_block(blockdata):
	var block_drop: Node2D = blockdata.block_shape.instantiate()
	to_parent.add_child(block_drop)
	block_drop.global_position = spawn_pos.global_position
#	block_drop.position = Vector2(462, 225)
	pass # Replace with function body.
