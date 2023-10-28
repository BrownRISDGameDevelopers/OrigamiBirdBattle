extends Node

@export var pc_launch: String # press button once to set angle, then press again to launch
@export var pc_fold_left: String
@export var pc_fold_right: String
@onready var player_manager = get_child(0)

var launch_flag = 0 # 0 = set angle, 1 = launch

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# ===== Launching Inputs =====
	if Input.is_action_just_released(pc_launch):
		if launch_flag == 0:
			player_manager.submit_launch(PlayerManager.LaunchingState.SETANGLE)
			launch_flag = 1
		else:
			player_manager.submit_launch(PlayerManager.LaunchingState.LAUNCH)
			launch_flag = 0
	
	# ===== Folding Inputs =====
	if Input.is_action_just_released(pc_fold_left):
		player_manager.submit_fold(PlayerManager.FoldingState.LEFT)
	if Input.is_action_just_released(pc_fold_right):
		player_manager.submit_fold(PlayerManager.FoldingState.RIGHT)
		
