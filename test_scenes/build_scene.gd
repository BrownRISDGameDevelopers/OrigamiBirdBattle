extends Node2D
class_name Builder

@onready var conveyor: Conveyor = $conveyor
@export var to_parent: Node2D
@export var spawn_pos: Node2D

var current_block = null

@export_flags_2d_physics var block_layer_mask: int = 0
@export_flags_2d_physics var block_collision_mask: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	if (to_parent == null):
		to_parent = self #get_parent()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
#	if(Input.is_action_just_released("queuePop")):
#		drop_block()
	

func drop_block():
	conveyor.try_pop()
#	conveyor.pop_block()
	pass


func _on_block_hit():
	current_block = null
	conveyor._setActive()
	


func _on_conveyor_drop_block(blockdata):
	var block_drop: BlockBase = blockdata.block_shape.instantiate() as BlockBase
	block_drop.collision_layer = block_layer_mask
	block_drop.collision_mask = block_collision_mask
	
#	to_parent.add_child(block_drop)
	to_parent.add_child(block_drop)

	block_drop.next_block.connect(_on_block_hit);
	#block_drop.global_position = spawn_pos.global_position
#	block_drop.global_scale = spawn_pos.global_scale
#	block_drop.scale = spawn_pos.scale
	block_drop.position = Vector2(conveyor.position.x, 150)
	
	current_block = block_drop
	pass # Replace with function body.
