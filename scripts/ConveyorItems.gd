extends ItemList


@export var item_num: int = 20
signal drop_block(blockdata)

const FILEPATH = "res://resources/block_resources/"
var queue = []
var blocks = DirAccess.open(FILEPATH).get_files()
	
# Called when the node enters the scene tree for the first time.
func _ready():
		for i in range(item_num):
			queue.push_back(blocks[randi() % len(blocks)])
		

func _pop_block():
	var blockres = queue.pop_front()
	var blockdata = load(FILEPATH + blockres)
	drop_block.emit(blockdata)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_released("queuePop"):
		_pop_block();
