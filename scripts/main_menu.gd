extends CanvasLayer


#@export var scene_to: String
# OF NOTE, can't use packedscenes for weird cyclic reasons
@export var start_to: String
@export var credits_to: String
@export var tutorial_to: String
@onready var start_game_button = $Start
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
#	scene_to = "prototype"
	$"../button_press".play()
	await get_tree().create_timer(0.40).timeout
	$"../button_press".stop()
	if(Globals.tutorial):
		Globals.tutorial = false

		get_tree().change_scene_to_file("res://levels/" + tutorial_to + ".tscn")
		
	else:
		
		get_tree().change_scene_to_file("res://levels/" + start_to + ".tscn")
#	get_tree().change_scene_to_packed(start_to)

func on_credit_button_down():
	$"../button_press".play()
	await get_tree().create_timer(0.40).timeout
	$"../button_press".stop()
#	scene_to = "credit_screen"
	get_tree().change_scene_to_file("res://levels/" + credits_to + ".tscn")
#	get_tree().change_scene_to_packed(credits_to)

func on_quit_button_down():
	$"../button_press".play()
	await get_tree().create_timer(0.40).timeout
	$"../button_press".stop()
	get_tree().quit()
