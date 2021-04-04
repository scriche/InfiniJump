extends KinematicBody2D

onready var ray = $RayCast2D
const GRAVITY = 400
const SPEED = 2000
var velocity = Vector2.ZERO
var direction = 1


func _physics_process(delta):
	
#	Movement Code for left are right movement
	velocity.x = 0
	if direction == 1:
		velocity.x += delta * SPEED
	if direction == 0:
		velocity.x -= delta * SPEED
		
	velocity.y += (delta * GRAVITY)
	
#	Checking if sides are colliding and not solliding with the player set the detection and direction to the other side
	if ray.is_colliding() and ray.get_collider().get_name() != "Player":
		if ray.get_collision_normal().x == -1:
			direction = 0
			ray.set_cast_to(Vector2(-3, 0))
		elif ray.get_collision_normal().x == 1:
			direction = 1
			ray.set_cast_to(Vector2(3, 0))
		
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)
