extends Node2D

@export var repeat_number: int = 3
var minigame

# Called when the node enters the scene tree for the first time.
func _ready():
	minigame = $PaperSprite
	minigame.start_rounds(repeat_number)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
