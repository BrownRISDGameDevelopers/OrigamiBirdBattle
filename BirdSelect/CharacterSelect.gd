extends Node2D

signal on_select

var selected_bird
var bird_array
var arr_index

# Called when the node enters the scene tree for the first time.
func _ready():
	var bird_1 = preload("res://assets/Art Folder/bird exp.1.png")
	var bird_2 = preload("res://assets/Art Folder/Origami birbs.jpg")
	var bird_3 = preload("res://assets/Art Folder/Screenshot 2023-07-17 at 11.13.49 AM.png")

	arr_index = 0
	
	selected_bird = bird_1
	bird_array = [bird_1, bird_2, bird_3]
	$Bird.set_texture(bird_array[arr_index])
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("select_left"):
		if arr_index > 0:
			arr_index -= 1
		else:
			arr_index = 2
		$Bird.set_texture(bird_array[arr_index])
			
			
	if Input.is_action_just_pressed("select_right"):
		if arr_index < 2:
			arr_index += 1
		else:
			arr_index = 0
		$Bird.set_texture(bird_array[arr_index])
			
	if Input.is_action_just_pressed("select_enter"):
		on_select.emit(bird_array[arr_index])



		
		

