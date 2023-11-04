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
var players_finished = 0
var best_player = 0
var best_height = 0

signal game_complete()

# Called when the node enters the scene tree for the first time.
func _ready():
	
	timer.wait_time = 2
	timer.connect("timeout", goto_next_state)
	timer.start()
	
	var i = 0
	# Add player managers in children 
	for child in get_children():
		if child is PlayerManager:
			child.num = i
			player_managers.append(child)
			child.hide_all()
			i += 1
		
	
#	minigame.start_rounds(3)
	print("minigame s")
	pass # Replace with function body.




func goto_next_state():
	timer.stop()
	# Go to build mode
	if cur_stage == Stage.START:
		for player in player_managers:
			player.set_build_mode()
		cur_stage = Stage.BUILDING
		timer.wait_time = 20
		timer.start()
		
	# Go to battle mode
	elif cur_stage == Stage.BUILDING:
		
		for player in player_managers:
			player.set_battle_mode()
		# enable battle stuff
		cur_stage = Stage.BATTLING
		timer.wait_time = 120
		timer.start()
		
	elif cur_stage == Stage.BATTLING:
		
		
		# Begin end game condition
		for player in player_managers:
			player.connect("end_game_height", get_new_winner)
		
		
		# Show ending screen
		cur_stage = Stage.COMPLETE


func get_new_winner(pos, player_num):
	players_finished += 1
	
	if pos > best_height:
		best_player = player_num
		
	if players_finished == player_managers.size():
		# end game
		game_complete.emit(best_player)
	
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
