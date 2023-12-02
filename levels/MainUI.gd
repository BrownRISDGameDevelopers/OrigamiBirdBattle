extends Control


@onready var end_label = $GameEnd
@onready var pause = $Pause
@export var game_manager: GameManager 
@export var game_end_sceen: PackedScene
@export var tutorial_screen: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pause.visible = false 
	end_label.visible = false
	$GameEnd/MainMenu.button_down.connect(on_main_menu)
	$Pause/MainMenu.button_down.connect(on_main_menu)
	$Pause/Tutorial.button_down.connect(on_tutorial)
	
	if (game_manager != null):
		game_manager.connect("game_complete", on_end)
	
	pass # Replace with function body.


func on_end(player_won: String):
	end_label.visible = true
	$GameEnd/EndLabel.text = player_won + " Wins!"
	

func on_main_menu():
	get_tree().change_scene_to_packed(game_end_sceen)
	
func on_tutorial():
	get_tree().change_scene_to_packed(tutorial_screen)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("pause")):
		get_tree().paused = !get_tree().paused
		pause.visible = get_tree().paused
	
	if (get_tree().paused and Input.is_action_just_pressed("restart")):
		get_tree().paused = false
		get_tree().change_scene_to_file("res://levels/" + "main_menu" + ".tscn")
		
		
