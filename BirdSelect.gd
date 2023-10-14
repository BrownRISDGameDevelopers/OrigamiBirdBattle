extends Node2D
signal on_select

var BirdSelect
var bird_array

# Called when the node enters the scene tree for the first time.
func _ready():
	BirdSelect = 0
	var bird_1  = preload("res://assets/temp_art/paper_bird.png")
	var bird_2 = preload("res://assets/temp_art/green_bird.png")
	var bird_3  = preload("res://assets/temp_art/orange_bird.png")
	bird_array = [bird_1, bird_2, bird_3]
	
func _set_texture(bird_array):
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_left"):
		if BirdSelect > 0:
			BirdSelect -= 1
			
	if Input.is_action_just_pressed("select_right"):
		if BirdSelect < 2:
			BirdSelect += 1
			
	match BirdSelect:
		0:
			get_node("BirdSelect").play("1")
			
		1:
			get_node("BirdSelect").play("2")
		2:
			get_node("BirdSelect").play("3")


		
		

