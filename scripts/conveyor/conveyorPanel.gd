extends Panel

@export var blockdata: Droppable_Block
@onready var background_sprite: Sprite2D = $bg
@onready var item_sprite: Sprite2D = $CenterContainer/Panel/item

# Called when the node enters the scene tree for the first time.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(bdata: Droppable_Block):
	item_sprite.texture = bdata.block_thumb
	blockdata = bdata
