extends Node2D

var rooms = [
	preload("res://scenes/Rooms/Room1.tscn"),
	preload("res://scenes/Rooms/Room2.tscn"),
	preload("res://scenes/Rooms/Room3.tscn"),
	preload("res://scenes/Rooms/Room4.tscn"),
	preload("res://scenes/Rooms/Room5.tscn"),
	preload("res://scenes/Rooms/Room6.tscn"),
]

var entitys = [
	preload("res://scenes/boost.tscn"),
	preload("res://scenes/Enemys/Jumper.tscn"),
	preload("res://scenes/Enemys/Rammer.tscn"),
	preload("res://scenes/Enemys/Spikeball.tscn"),
	preload("res://scenes/Enemys/Walker.tscn"),
	preload("res://scenes/Enemys/Walker_Bouncetop.tscn"),
	preload("res://scenes/Enemys/Walker_Hardtop.tscn"),
]

var RWIDTH = 144
var RHIGHT = 88
var cb = 0
var spawnpos
onready var test = $Test

func _ready():
	#Seeding the day month and year for a new level every day
	var time = OS.get_datetime()
	var dayhash = time["year"] + time["day"] + time["month"]
	seed(dayhash)
	
	for x in range(10):
		#Spawning of Rooms
		var room = rooms[randi() % len(rooms)]
		var instance = room.instance()
		get_parent().call_deferred("add_child",instance)
		instance.transform = global_transform
		if (x % 2) == 0:
			instance.scale.x = -1
			instance.position.x += 144
		
		#Spawning of enemys and double jumps
		for _y in range(randi() % 4):
			#var entity = entitys[randi() % len(entitys)]
			#var insstance = entity.instance()
			var insstance = entitys[0].instance()
			get_parent().call_deferred("add_child",insstance)
			while true:
				spawnpos = Vector2(global_position.x + randi()%RWIDTH, global_position.y - randi()%RHIGHT)
				test.global_position = spawnpos
				if cb == 0:
					insstance.position = spawnpos
					break
		position.y -= 88
		

func _on_Test_body_entered(_body):
	cb += 1


func _on_Test_body_exited(_body):
	cb -= 1
