extends KinematicBody2D

const SPEED = 3300
const GRAVITY = 400
const JUMP_POWER = -120
var direction = 1
onready var particles2D = $Particles2D
var start
var velocity = Vector2.ZERO
var startpos
var jumps = 0
var collision

signal moved
signal reset

func _ready():
	startpos = position

func respawn():
	#Call this function the respawn play and reset timer
	position = startpos
	direction = 1
	emit_signal("reset")

func run(delta):
	velocity.x = 0
	if direction == 1:
		velocity.x += delta * SPEED
	if direction == 0:
		velocity.x -= delta * SPEED

func jump():
		start = true
		
		#if you jump off a wall switch directions 
		if is_on_wall() && !is_on_floor():
			velocity.y = JUMP_POWER
			if direction == 0:
				direction = 1
			else:
				direction = 0
		elif is_on_floor() or jumps > 0:
			if !is_on_floor() and jumps > 0:
				jumps -= 1
			velocity.y = JUMP_POWER

func _physics_process(delta):
	#Hit wall and flip dirrection detection
	if is_on_floor() and is_on_wall() and collision.collider.get_name() == "TileMap":
		if direction == 0:
			direction = 1
		else:
			direction = 0
	#A jump start method to start running only if jump has been press once
	if start:
		run(delta)
		
	#Gravity for wall and normal
	if is_on_wall() && velocity.y > 10:
		velocity.y = (delta * GRAVITY) * 3
		particles2D.emitting = true
	else:
		velocity.y += (delta * GRAVITY)
		particles2D.emitting = false
	
	
	#hit detection for anything and for specific tileset tiles
	for i in get_slide_count():
		collision = get_slide_collision(i)
		if collision.collider is TileMap:
			var tile_pos = collision.collider.world_to_map(position)
			tile_pos -= collision.normal
			var tile_id = collision.collider.get_cellv(tile_pos)
			var tile_name = collision.collider.tile_set.tile_get_name(tile_id)
			if tile_name == "spike":
				respawn()
		elif collision.collider_shape.is_in_group("enemy"):
			respawn()
		elif collision.collider_shape.is_in_group("bouncy"):
			velocity = -240
	
	#Sending position up the line to the camera so it can track the player
	emit_signal("moved", position)
	
	#once and velocity calculation are added move the player
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_touchzone_pressed():
	jump()
