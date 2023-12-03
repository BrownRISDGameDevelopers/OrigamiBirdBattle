extends Node2D

@export var textures: Array[CompressedTexture2D]
@export var goto_scene_on_end: String
@export var delay: float = .75

@onready var text_rect: TextureRect = $TextureRect

var cur_text_in: int = 0

func _ready():
	text_rect.texture = textures[cur_text_in]
	$next2.hide()
	$back.hide()


func _on_next_pressed():
	$button_press.play()
	await get_tree().create_timer(0.40).timeout
	$button_press.stop()
	if (cur_text_in < textures.size() - 1):
		cur_text_in += 1
		text_rect.texture = textures[cur_text_in]
		$back.show()
		if cur_text_in == textures.size() - 1:
			$next.hide()
			$next2.show()
		else:
			$next.show()
			$next2.hide()
	else:
		cur_text_in += 1
		text_rect.texture = textures[cur_text_in]
		$next.hide()
		$start_button.show()
	
	pass # Replace with function body.


func _on_back_pressed():
	$button_press.play()
	await get_tree().create_timer(0.40).timeout
	$button_press.stop()
	if (cur_text_in > 0):
		cur_text_in -= 1
		text_rect.texture = textures[cur_text_in]
		$next.show()
		$start_button.hide()
	if (cur_text_in == 0):
		$back.hide()
	if cur_text_in == textures.size() - 1:
		$next.hide()
		$next2.show()
	else:
		$next.show()
		$next2.hide()
	pass # Replace with function body.


func _on_start_button_pressed():
	$start.play()
	await get_tree().create_timer(0.40).timeout
	$start.stop()
	get_tree().change_scene_to_file("res://levels/" + goto_scene_on_end + ".tscn")
	pass # Replace with function body.
