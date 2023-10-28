extends RigidBody2D

signal on_tap()
signal on_col()

@export var rb_mass: float = 1.0
@export var deathParticle: PackedScene
@onready var health: Health = $Health

# Called when the node enters the scene tree for the first time.
func _ready():
	mass = rb_mass
	pass # Replace with function body.

func tap():
	on_tap.emit()
	
func kill():
	var _particle = deathParticle.instantiate()
	_particle.position = position
	_particle.rotation - rotation
	_particle.emitting = true
	get_tree().current_scene.add_child(_particle)
	queue_free()

func _on_body_entered(body):
	on_col.emit()
	kill()
	#pass # Replace with function body.
