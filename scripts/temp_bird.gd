extends BirdBase
@onready var _animated_sprite = $AnimatedSprite2D

# var force_vector

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_animated_sprite.play("flying")

func _physics_process(delta):
	pass
	# Do birds need to apply their own force? Or 
	# apply_central_force(force_vector)
