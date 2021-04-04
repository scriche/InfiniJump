extends Timer

func _process(_delta):
	if Input.is_action_just_pressed("ui_up"):
		start()
