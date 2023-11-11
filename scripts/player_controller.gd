extends Node

@export var pc_launch: String # press button once to set angle, then press again to launch
@export var pc_fold_left: String
@export var pc_fold_right: String
@export var build: String
@export var player_manager: PlayerManager

var launch_flag = 0 # 0 = set angle, 1 = launch


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
#	if player_manager.state == player_manager.GenState.BUILD:
		# ===== Build Inputs =====
	if Input.is_action_just_pressed(build):
		player_manager.try_drop_block()
	
	# Its not folding controls! We're lying its just for build movement
	if Input.is_action_pressed(pc_fold_left):
		player_manager.move_block_left()
	elif Input.is_action_pressed(pc_fold_right):
		player_manager.move_block_right()
		
	if player_manager.state == player_manager.GenState.FOLD:
		# ===== Folding Inputs =====
		if Input.is_action_just_pressed(pc_launch):
			player_manager.submit_fold(PlayerManager.FoldingState.LEFT)
#		elif Input.is_action_just_pressed(pc_fold_right):
#			player_manager.submit_fold(PlayerManager.FoldingState.RIGHT)
	
	if player_manager.state == player_manager.GenState.FIRE:
		# ===== Launching Inputs =====
		if Input.is_action_just_pressed(pc_launch):
			if launch_flag == 0:
				print("launch")
				player_manager.submit_launch(PlayerManager.LaunchingState.SETANGLE)
				launch_flag = 1
			else:
				player_manager.submit_launch(PlayerManager.LaunchingState.LAUNCH)
				launch_flag = 0
			
	
	
		
