extends Node2D
class_name Health

@export var health: int = 10
@export var max_health: int = 10
signal death()



func set_max_health_and_health(to_set):
	max_health = to_set
	health = to_set

func heal(amt):
	health = min(max_health, health + amt)

func damage(amt):
	health -= amt
	if (health <= 0):
		die()

func die():
	death.emit()

