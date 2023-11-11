class_name PlayerManager
extends Node2D

#enum BattleState {
#	SELECT,
#	FOLD,
#	FIRE,
#}
#
#enum BuildState {
#	SELECT,
#	DROP,
#}

enum GenState {
	FIRE,
	FOLD,
	COMPLETE,
	BUILD,
}

enum FoldingState {
	LEFT,
	RIGHT
}

enum LaunchingState {
	SETANGLE,
	LAUNCH
}

# global states variable, a short hand for the global stage enum
var gs = Globals.Stage
var cur_state: Globals.Stage = gs.BATTLING
#var cur_build_state: BuildState = BuildState.SELECT
#var cur_battle_state: BattleState = BattleState.SELECT



var num: int = -1

@onready var folding_game: FoldingMinigame = $FoldingMinigame
@onready var bird_launcher: BirdLauncher = $Firing
@onready var building_game: Builder = $Building
@onready var check_height: CheckHeight = $CheckHeight


var state: GenState = GenState.BUILD

signal end_game_height(height, player_num)

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	folding_game.connect("finish", battle_goto_launch, CONNECT_ONE_SHOT)
#	battle_goto_fold()
	
	pass # Replace with function body.

func hide_all():
	building_game.hide()
	bird_launcher.hide()
	folding_game.hide()

func set_battle_mode():
	# hide build stuff
	building_game.show()
#	building_game.hide()
	# show battle stuff
	battle_goto_fold()
	

func set_build_mode():
	state = GenState.BUILD
	# hide battle stuff
	bird_launcher.hide()
	folding_game.hide()
	building_game.show()
	# show build stuff
	pass

func set_end_game():
	state = GenState.COMPLETE
	bird_launcher.hide()
	folding_game.hide()
	building_game.hide()
	
	if (check_height != null):
		check_height.game_end()
		check_height.connect("height_found", on_height_obtained)

func on_height_obtained(pos: float):
	end_game_height.emit(pos, num)


func battle_goto_launch():
	state = GenState.FIRE
	if (folding_game):
		folding_game.hide()
	bird_launcher.show()
	bird_launcher.launched.connect(battle_goto_fold, CONNECT_ONE_SHOT)
	

func battle_goto_fold_wrap(angle):
	battle_goto_fold()


func try_drop_block():
	if (building_game.visible):
		building_game.drop_block()
#func battle_goto_select():
#	folding_game.hide()

func battle_goto_fold():
	state = GenState.FOLD
	folding_game.show()
	folding_game.connect("finish", battle_goto_launch, CONNECT_ONE_SHOT)
	folding_game.start_rounds(3)
	bird_launcher.hide()

func submit_fold(fold_state):
	if (folding_game.visible):
		folding_game._timing_press(0)
#	folding_game.process_folding_input(fold_state)

func submit_launch(launch_state):
	if (bird_launcher.visible):
		bird_launcher.process_launching_input(launch_state)

#func build_goto


func _manage_battle_state():
	pass

func _manage_build_state():
	pass
	
func move_block_left():
	if building_game.current_block != null:
		building_game.current_block.left()
	
func move_block_right():
	if building_game.current_block != null:
		building_game.current_block.right()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if cur_state == gs.BATTLING:
		_manage_battle_state()
	elif cur_state == gs.BUILDING:
		_manage_build_state()
		pass
	pass
