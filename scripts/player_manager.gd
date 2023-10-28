class_name PlayerManager
extends Node2D

enum BattleState {
	SELECT,
	FOLD,
	FIRE,
}

enum BuildState {
	SELECT,
	DROP,
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
var cur_build_state: BuildState = BuildState.SELECT
var cur_battle_state: BattleState = BattleState.SELECT

@onready var folding_game: FoldingMinigame = $FoldingMinigame
# todo: add typing for bird_launcher
@onready var bird_launcher: BirdLauncher = $Firing

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	folding_game.connect("finish", battle_goto_launch, CONNECT_ONE_SHOT)
	battle_goto_fold()
	
	pass # Replace with function body.


func set_battle_mode():
	# hide build stuff
	# show battle stuff
	battle_goto_fold()

func set_build_mode():
	# hide battle stuff
	bird_launcher.hide()
	folding_game.hide()
	
	# show build stuff
	pass


func battle_goto_launch():
	folding_game.hide()
	bird_launcher.connect("launched", battle_goto_fold_wrap, CONNECT_ONE_SHOT)
	bird_launcher.show()

func battle_goto_fold_wrap(angle):
	battle_goto_fold()
	
#func battle_goto_select():
#	folding_game.hide()

func battle_goto_fold():
	folding_game.show()
	folding_game.connect("finish", battle_goto_launch, CONNECT_ONE_SHOT)
	folding_game.start_rounds(3)
	bird_launcher.hide()

func submit_fold(fold_state):
	folding_game.process_folding_input(fold_state)

func submit_launch(launch_state):
	bird_launcher.process_launching_input(launch_state)

#func build_goto


func _manage_battle_state():
	pass

func _manage_build_state():
	pass



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if cur_state == gs.BATTLING:
		_manage_battle_state()
	elif cur_state == gs.BUILDING:
		_manage_build_state()
		pass
	pass
