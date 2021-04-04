extends Label

onready var start_time = OS.get_ticks_msec()
var milisecs = 0
var seconds = 0
var mins = 0

func _on_Timer_timeout():
	milisecs += 1

func _process(_delta):
	if milisecs >= 10:
		seconds += 1
		milisecs = 0
		if seconds >= 60:
			mins += 1
			seconds = 0
	text = str(mins, ":", seconds, ":", milisecs)


func _on_Player_reset():
	milisecs = 0
	seconds = 0
	mins = 0
