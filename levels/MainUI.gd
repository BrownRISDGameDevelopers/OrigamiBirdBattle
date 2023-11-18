extends Control


@onready var end_label = $GameEnd/EndLabel
@export var game_manager: GameManager 

# Called when the node enters the scene tree for the first time.
func _ready():
	
	if (game_manager != null):
		game_manager.connect("game_complete", on_end)
	
	pass # Replace with function body.


func on_end(player_won: String):
	end_label.visible = true
	end_label.text = player_won + " Wins!"
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
