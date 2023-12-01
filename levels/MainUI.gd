extends Control


@onready var end_label = $GameEnd
@export var game_manager: GameManager 
@export var game_end_sceen: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	end_label.visible = false
	$GameEnd/MainMenu.button_down.connect(on_main_menu)
	
	if (game_manager != null):
		game_manager.connect("game_complete", on_end)
	
	pass # Replace with function body.


func on_end(player_won: String):
	end_label.visible = true
	$GameEnd/EndLabel.text = player_won + " Wins!"
	

func on_main_menu():
	get_tree().change_scene_to_packed(game_end_sceen)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
