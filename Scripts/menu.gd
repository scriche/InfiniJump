extends ColorRect


func _ready():
	pass


func _on_Button_toggled(button_pressed):
	if button_pressed:
		visible = true
	else:
		visible = false
