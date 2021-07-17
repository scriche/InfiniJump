extends StaticBody2D

var bullet = preload("res://scenes/Enemys/Bullet.tscn")

func _ready():
	pass

func shoot():
	var b = bullet.instance()
	owner.add_child(b)
	b.transform = global_transform
	

func _on_Timer_timeout():
	shoot()
