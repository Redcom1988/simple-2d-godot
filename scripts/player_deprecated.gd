extends Area2D

@export var speed = 150
@export var health = 100
@export var atkdmg = 25
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	#velocity = input_direction * speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	$AnimatedSprite2D.play()

	var lastHorizontalVelocity = 0
	var lastHeldMovementKey = 0
	
	if velocity.x != 0 || velocity.y != 0:
		$AnimatedSprite2D.animation = "move"
		$AnimatedSprite2D.flip_h = velocity.x < 0
		if velocity.x != 0:
			lastHorizontalVelocity = velocity.x
	else:
		$AnimatedSprite2D.animation = "idle"
		$AnimatedSprite2D.flip_h = lastHorizontalVelocity < 0
	
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
