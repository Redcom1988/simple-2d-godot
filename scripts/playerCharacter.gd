extends CharacterBody2D
signal ping

@export var speed = 150
@export var dead = false
#var currentPos : Transform2D
var lastHorizontalVelocity : int  
var held_duration : float
var viewport_size : Vector2

func _ready():
	viewport_size = get_viewport_rect().size
	position = get_viewport().size / 2
	#position = Vector2(randf_range(0, viewport_size.x), randf_range(0, viewport_size.y))
	scale = Vector2(2, 2)

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	#input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if input_direction.length() > 1:
		input_direction = input_direction.normalized()
	velocity = input_direction * speed

func _physics_process(delta):
	get_input()
	animation_handler()
	clampEntity()
	move_and_collide(velocity * delta)
	attackHandler(delta)
	

func attackHandler(delta):
	if Input.is_action_pressed("lmb"):
		held_duration += delta
		if held_duration < 0.2:
			$AnimatedSprite2D.animation = "death"
		else:
			$AnimatedSprite2D.animation = "channel"
			if held_duration == 1.5:
				var attackCharged = true
	elif (Input.is_action_just_released("lmb")):
		held_duration = 0
	
	print(held_duration)

func clampEntity():
	position.x = clamp(position.x, 0 + $CollisionShape2D.get_shape().radius , viewport_size.x - $CollisionShape2D.get_shape().radius)
	position.y = clamp(position.y, 0 + $CollisionShape2D.get_shape().height , viewport_size.y - $CollisionShape2D.get_shape().height)

	#currentPos = get_global_transform()
	
	#if currentPos.origin.x <= 0 + entityShape.radius && input_direction.x <= 0 || currentPos.origin.x >= viewport_size.x - entityShape.radius && input_direction.x >= 0:
		#velocity.x = 0
	#if currentPos.origin.y <= 0 + entityShape.height && input_direction.y <= 0 || currentPos.origin.y >= viewport_size.y - entityShape.height && input_direction.y >= 0:
		#velocity.y = 0

func animation_handler():
	get_input()

	if dead:
		$AnimatedSprite2D.animation = "death"
		$AnimatedSprite2D.stop()
	elif held_duration > 0:
		$AnimatedSprite2D.animation = "channel"
	elif velocity != Vector2.ZERO:
		$AnimatedSprite2D.animation = "move"
	else:
		$AnimatedSprite2D.play()
		$AnimatedSprite2D.animation = "idle"

	if velocity.x != 0:
		lastHorizontalVelocity = velocity.x
		$AnimatedSprite2D.flip_h = lastHorizontalVelocity < 0
