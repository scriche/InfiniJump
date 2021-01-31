extends Polygon2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _process(delta):
	#if (position != Vector2(sin(position.x), positon.y)):
	position.x = move_toward(position.x, position.x+0.05, 2)
	position.y = move_toward(position.y, sin(position.x) + position.y, 2)
