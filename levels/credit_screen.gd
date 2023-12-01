extends Node2D


func _ready():
	$MainMenu.button_down.connect(on_tutorial_button_down)
	
func on_tutorial_button_down():
	get_tree().change_scene_to_file("res://levels/" + "main_menu" + ".tscn")

