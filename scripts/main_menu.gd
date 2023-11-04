extends CanvasLayer


@export var scene_to: String
@onready var start_game_button = $StartGame
@onready var credits_button = $Credits
@onready var quit_button = $Quit

# Called when the node enters the scene tree for the first time.
func _ready():	
	start_game_button.button_down.connect(on_start_button_down)
	credits_button.button_down.connect(on_credit_button_down)
	quit_button.button_down.connect(on_quit_button_down)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_start_button_down():
	scene_to = "prototype"
	get_tree().change_scene_to_file("res://levels/" + scene_to + ".tscn")

func on_credit_button_down():
	scene_to = "credit_screen"
	get_tree().change_scene_to_file("res://test_scenes/" + scene_to + ".tscn")

func on_quit_button_down():
	get_tree().quit()
