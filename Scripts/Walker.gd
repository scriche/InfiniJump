extends KinematicBody2D

onready var ray = $RayCast2D
onready var feet = $RayCast2D2
onready var sprite = $AnimatedSprite
onready var col = $CollisionPolygon2D
onready var player = $"/root/Level/Game/Player"
var sight
var timer
const GRAVITY = 400
const SPEED = 2000
var velocity = Vector2.ZERO
var direction = 1
var chargepos

func _ready():
	if self.get_name() == "Rammer":
		timer = get_node("Timer")
		sight = get_node("Sight")

func flipr():
	direction = 0
	if self.get_name() == "Rammer":
		sight.set_cast_to(Vector2(-100, 0))
		feet.position = Vector2(-4, 2)
	else:
		feet.position = Vector2(-2, 2)
	ray.set_cast_to(Vector2(-5, 0))
	sprite.scale.x = -1
	col.scale.x = -1
	
func flipl():
	direction = 1
	if self.get_name() == "Rammer":
		sight.set_cast_to(Vector2(100, 0))
		feet.position = Vector2(4, 2)
	else:
		feet.position = Vector2(2, 2)
	ray.set_cast_to(Vector2(5, 0))
	sprite.scale.x = 1
	col.scale.x = 1
	
func _physics_process(delta):
	
#	Movement Code for left are right movement
	velocity.x = 0
	if direction == 1:
		velocity.x += delta * SPEED
	if direction == 0:
		velocity.x -= delta * SPEED
	if direction == 2:
		velocity.x += delta * SPEED * 3
	if direction == 3:
		velocity.x -= delta * SPEED * 3
	if direction == 4:
		pass
	velocity.y += (delta * GRAVITY)
	if self.get_name() == "Rammer":
		if direction == 1 or direction == 0:
			if sight.is_colliding():
				var thing = sight.get_collider()
				if thing.get_name() == "Player":
					timer.start(1)
					direction = 4
	
#	Checking if sides are colliding and not colliding with the player set the detection and direction to the other side
	if ray.is_colliding() and ray.get_collider().get_name() != "Player":
		if ray.get_collision_normal().x == -1:
			flipr()
			
		elif ray.get_collision_normal().x == 1:
			flipl()
			
	if not feet.is_colliding():
		if direction == 1:
			flipr()
			
		else:
			flipl()
			
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.slide(collision.normal)

func _on_Timer_timeout():
	if sprite.scale.x == 1:
		direction = 2
	else:
		direction = 3
	
