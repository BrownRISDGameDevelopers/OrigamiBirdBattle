class_name BlockBase extends RigidBody2D


@export var health: int = 5
@export var sturdiness: int = 3
@export var texture: Texture2D = preload("res://icon.svg")

@onready var health_node: Health = $Health
@onready var sprite: Sprite2D = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	mass = sturdiness
	health_node.set_max_health_and_health(health)
	sprite.set_texture(texture)
