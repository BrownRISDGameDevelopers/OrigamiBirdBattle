extends Control

@export var item_num: int = 20
@onready var conveyor_display: Array = $NinePatchRect/conveyor_grid.get_children()
signal drop_block(blockdata)

const FILEPATH = "res://resources/block_resources/"
var queue = []
var blocks = DirAccess.open(FILEPATH).get_files()
	
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in range(item_num):
		addBlock()
	
	for i in range(conveyor_display.size()):
		conveyor_display[i].update(queue[i])
			
func addBlock():
	var blockdata = load(FILEPATH + blocks[randi() % len(blocks)])
	queue.push_back(blockdata)
	
func _pop_block():
	if(queue.size() == conveyor_display.size()):
		for i in range(blocks.size()):
			addBlock()
	var blockdata = queue.pop_front()
	for i in range(conveyor_display.size()):
		conveyor_display[i].update(queue[i])
	drop_block.emit(blockdata)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("queuePop"):
		_pop_block();
