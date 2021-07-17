extends StaticBody2D

onready var ray = $RayCast2D
onready var timer = $Timer
var crumbling = false
func _ready():
	pass

func _process(delta):
	if ray.is_colliding() and crumbling == false:
		if ray.get_collider().get_name() == "Player":
			print("start")
			timer.start(0.5)
			crumbling = true

func _on_Timer_timeout():
	if visible:
		visible = false
		timer.start(3)
	else:
		visible = true
		crumbling = false
