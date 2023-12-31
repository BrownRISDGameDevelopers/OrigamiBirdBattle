class_name BirdBase
extends RigidBody2D

signal on_tap()
signal on_col()

@export var rb_mass: float = 1.0
@export var deathParticle: PackedScene
@onready var health: Health = $Health
@onready var timer: Timer = $Timer
@onready var animated: AnimatedSprite2D = $AnimatedSprite2D
var collided = false

@onready var audio: RandomAudio = $Audio

# Called when the node enters the scene tree for the first time.
func _ready():
	mass = rb_mass
	$Explosion.set_visible(false)
	animated.play("flying")
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
	#$Sprite2D.set_visible(false)
	animated.set_visible(false)
	audio.play(randf_range(1.25, 1.3))
	# disable collisions
	collision_mask = 0
	collision_layer = 0
#	$ExplosionSound.play(.23)
	self.set_sleeping(true)
	on_col.emit()
	await get_tree().create_timer(0.40).timeout
#	audio.stop()
	
	await get_tree().create_timer(0.13).timeout
	$Explosion.set_visible(false)
	
	
	
	# this timer will destroy bird
	timer.start(3)
#	kill()
	#pass # Replace with function body.


func _on_timer_timeout():
	kill()
	pass # Replace with function body.
