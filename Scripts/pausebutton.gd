extends Button


func _ready():
	pass

func _toggled(button_pressed):
	get_tree().paused = button_pressed
