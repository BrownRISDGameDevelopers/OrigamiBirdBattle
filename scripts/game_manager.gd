# finite state machine that organizes broad logic

class_name GameManager
extends Node2D



enum Stage {
	START,
	BUILDING,
	BATTLING,
	COMPLETE,
}

#@onready var minigame: FoldingMinigame = $FoldingMinigame

var cur_stage: Stage = Stage.START


@onready var timer: Timer = $Timer

# Start
# - ready game
# - start timer for transition, go into build mode
# build mode
# - drop and use arrow keys to move
# - on timer done, go to battle
# Battle mode
# - select
# - launch 

var player_managers: Array[PlayerManager] = []


# Called when the node enters the scene tree for the first time.
func _ready():
	
	timer.wait_time = 5
	timer.connect("timeout", goto_next_state)
	timer.start()
	
	# Add player managers in children 
	for child in get_children():
		if child is PlayerManager:
			player_managers.append(child)
	
#	minigame.start_rounds(3)
	print("minigame s")
	pass # Replace with function body.




func goto_next_state():
	if cur_stage == Stage.START:
		# enable build stuff
		cur_stage = Stage.BUILDING
	if cur_stage == Stage.BUILDING:
		timer.wait_time = 20
		timer.start()
		player_managers[0].
		# enable battle stuff
		cur_stage = Stage.BATTLING
	if cur_stage == Stage.BATTLING:
		timer.wait_time = 120
		timer.start()
		# Show ending screen
		cur_stage = Stage.COMPLETE

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
