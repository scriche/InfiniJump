extends StaticBody2D

onready var chain = $Line2D
onready var ball = $Ball
onready var base = $Base
onready var col = $CollisionPolygon2D

func _ready():
	pass

func _process(delta):
	chain.set_point_position(1, ball.position)
	chain.set_point_position(0, base.position)
	col.position = ball.position
	ball.position = base.position + (ball.position - base.position).rotated(0.01)
