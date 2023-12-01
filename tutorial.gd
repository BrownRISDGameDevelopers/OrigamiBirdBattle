extends Node2D

@export var textures: Array[CompressedTexture2D]
@export var goto_scene_on_end: PackedScene 
@export var delay: float = .75

@onready var text_rect: TextureRect = $TextureRect

var cur_text_in: int = 0
var cur_delay: float = .5

func _ready():
	text_rect.texture = textures[cur_text_in]

func _process(delta):
	
	if (cur_delay > 0):
		cur_delay -= delta


func _unhandled_key_input(event):
	if event.is_pressed():
		
		if (cur_delay <= 0):
			
			if (cur_text_in < textures.size() - 1):
				cur_text_in += 1
				text_rect.texture = textures[cur_text_in]
				cur_delay = delay
				return
			
			get_tree().change_scene_to_packed(goto_scene_on_end)

		
		
