extends Area2D
class_name HitboxComponent

@export var health_compponent : HealthComponent


# Called when the node enters the scene tree for the first time.
func damage(attack: Attack):
	if health_compponent:
		health_compponent.damage(attack)
