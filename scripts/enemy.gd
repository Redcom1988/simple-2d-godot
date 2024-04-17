extends CharacterBody2D

@export var speed = 150
@export var entity_alive = true
var viewport_size : Vector2

func _ready():
	viewport_size = get_viewport_rect().size
	position = get_viewport().size / 2
	#position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	scale = Vector2(2, 2)

func _physics_process(delta):
	if entity_alive:
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
