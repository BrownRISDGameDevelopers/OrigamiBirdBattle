# finite state machine that organizes broad logic

class_name GameManager
extends Node2D



enum Stage {
	BUILDING,
	BATTLING,
	COMPLETE,
}

#@onready var minigame: FoldingMinigame = $FoldingMinigame

var cur_stage: Stage = Stage.BATTLING

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	minigame.start_rounds(3)
	print("minigame s")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
