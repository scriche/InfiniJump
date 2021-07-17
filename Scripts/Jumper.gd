extends KinematicBody2D

onready var timer = $Timer
onready var ray = $RayCast2D
onready var sight = $Sight
var velocity = Vector2.ZERO
const GRAVITY = 400
const SPEED = 2000
var direction = 0
var cooldown
func _ready():
	pass

func _physics_process(delta):
	
	
	velocity.y += (delta * GRAVITY)
	
	var collision = move_and_collide(velocity * delta)
	velocity.x = 0
	if collision:
		velocity = velocity.slide(collision.normal)
	elif collision == null:
		if direction == 0:
			velocity.x += delta * SPEED
		elif direction == 1:
			velocity.x += delta * -SPEED
	
	if ray.get_collision_normal().x == -1:
		direction = 1
		ray.set_cast_to(Vector2(-5, 0))
		sight.set_cast_to(Vector2(-100, 0))
	elif ray.get_collision_normal().x == 1:
		direction = 0
		ray.set_cast_to(Vector2(5, 0))
		sight.set_cast_to(Vector2(100, 0))
	
	if sight.is_colliding():
		if sight.get_collider().get_name() == "Player":
			cooldown = 0.4
		else:
			cooldown = 1
	print(cooldown)
	
func jump():
	if sight.is_colliding():
		if sight.get_collider().get_name() == "Player":
			velocity.y += -80
		else:
			velocity.y += -120
	else:
		velocity.y += -120
	
func _on_Timer_timeout():
	jump()
	timer.start(cooldown)
