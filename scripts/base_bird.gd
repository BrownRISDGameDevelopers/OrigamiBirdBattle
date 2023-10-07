extends RigidBody2D

signal on_tap()
signal on_col()

@export var rb_mass: float = 1.0
@onready var health: Health = $Health

# Called when the node enters the scene tree for the first time.
func _ready():
	
	mass = rb_mass
	pass # Replace with function body.


func tap():
	on_tap.emit()

# func col():
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
