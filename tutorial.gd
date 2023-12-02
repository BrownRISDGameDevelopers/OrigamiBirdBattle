extends Node2D

@export var textures: Array[CompressedTexture2D]
@export var goto_scene_on_end: String
@export var delay: float = .75

@onready var text_rect: TextureRect = $TextureRect

var cur_text_in: int = 0

func _ready():
	text_rect.texture = textures[cur_text_in]

	
		


func _on_next_pressed():
	if (cur_text_in < textures.size() - 1):
		cur_text_in += 1
		text_rect.texture = textures[cur_text_in]
		$back.show()
	else:
		get_tree().change_scene_to_file("res://levels/" + goto_scene_on_end + ".tscn")
	pass # Replace with function body.


func _on_back_pressed():
	if (cur_text_in > 0):
		cur_text_in -= 1
		text_rect.texture = textures[cur_text_in]
	if (cur_text_in == 0):
		$back.hide()
	pass # Replace with function body.
