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
	READY,
	SETANGLE,
	LAUNCH
}

# signals for communication between player controller and player manager
signal folding_input(fold_input)
signal launching_input(launch_input)

# global states variable, a short hand for the global stage enum
var gs = Globals.Stage
var cur_state: Globals.Stage = gs.BATTLING
var cur_build_state: BuildState = BuildState.SELECT
var cur_battle_state: BattleState = BattleState.SELECT

@onready var folding_game: FoldingMinigame = $FoldingMinigame
# todo: add typing for firing
@onready var firing = $Firing
@onready var building_game = $Building

# Called when the node enters the scene tree for the first time.
func _ready():
	
#	folding_game.connect("finish", battle_goto_launch, CONNECT_ONE_SHOT)
#	battle_goto_fold()
	
	pass # Replace with function body.


func set_battle_mode():
	# hide build stuff
	building_game.hide()
	# show battle stuff
	battle_goto_fold()

func set_build_mode():
	# hide battle stuff
	firing.hide()
	folding_game.hide()
	building_game.show()
	# show build stuff
	pass


func battle_goto_launch():
	folding_game.hide()
	firing.connect("launched", battle_goto_fold_wrap, CONNECT_ONE_SHOT)
	firing.show()

func battle_goto_fold_wrap(angle):
	battle_goto_fold()
	
#func battle_goto_select():
#	folding_game.hide()

func battle_goto_fold():
	folding_game.show()
	folding_game.connect("finish", battle_goto_launch, CONNECT_ONE_SHOT)
	folding_game.start_rounds(3)
	firing.hide()

func submit_fold(fold_state):
	folding_input.emit(fold_state)
	
func submit_launch(launch_state):
	launching_input.emit(launch_state)

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
