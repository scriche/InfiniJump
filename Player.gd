extends KinematicBody2D

const SPEED = 40
const GRAVITY = 10
const JUMP_POWER = -50
const FLOOR = Vector2(0, -1)
var direction = 1
onready	var particles2D = $Particles2D

var velocity = Vector2()

func input():
	
	if Input.is_action_pressed("ui_up"):
		if is_on_floor():
			velocity.y += JUMP_POWER
	
	if Input.is_action_just_pressed("ui_left"):
		if direction == 0:
			direction = 1
		else:
			direction = 0

	if Input.is_action_pressed("ui_accept"):
		pass

func _ready():
	pass

func run():
	velocity.x = 0
	if direction == 1:
		velocity.x += SPEED
	if direction == 0:
		velocity.x -= SPEED
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y += JUMP_POWER
		elif is_on_wall() && !is_on_floor():
			velocity.y += JUMP_POWER
			if direction == 0:
				direction = 1
			else:
				direction = 0

func _physics_process(delta):
	particles2D.emitting = false
	input()
	run()
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_wall():
		#velocity.y = 0
		if velocity.y < 25:
			velocity.y += 0.1	
		particles2D.emitting = true
		
	else:
		if velocity.y < 85:
			velocity.y += 4.8
