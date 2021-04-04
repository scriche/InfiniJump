extends Camera2D

var bottom
var diff
onready var player = $"/root/Level/Game/Player"

func _ready():
	bottom = position
	diff = player.position - position

func _process(_delta):
	pass
	#position = position.linear_interpolate(player.position, 1)


func _on_Player_moved(target):
		position = position.linear_interpolate((target - diff), 0.05)
		if  position.y > -48:
			position.y = -48
		position.x = 0
