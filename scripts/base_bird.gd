class_name BirdBase
extends RigidBody2D

signal on_tap()
signal on_col()

@export var rb_mass: float = 1.0
@export var deathParticle: PackedScene
@onready var health: Health = $Health
var collided = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mass = rb_mass
	$Explosion.set_visible(false)	
	#$ExplosionAnimationPlayer.play("cartoon_explosion")
	pass # Replace with function body.

func tap():
	on_tap.emit()
	
	
func kill():
	#var _particle = deathParticle.instantiate()
	#_particle.position = position
	#_particle.rotation - rotation
	#_particle.emitting = true
	#get_tree().current_scene.add_child(_particle)
	queue_free()

func _on_body_entered(body):
	collided = true
	print("BODY ENTERED BIRD LKSDJFKLSDJFLSKFS")
	$Explosion.set_visible(true)
	$ExplosionAnimationPlayer.play("cartoon_explosion")
	$Sprite2D.set_visible(false)
	$ExplosionSound.play()
	self.set_sleeping(true)
	on_col.emit()
	await get_tree().create_timer(0.40).timeout
	$ExplosionSound.stop()
	await get_tree().create_timer(0.13).timeout
	$Explosion.set_visible(false)
	kill()
	#pass # Replace with function body.
