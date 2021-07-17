extends KinematicBody2D

var initpos
var topos
var speed = 25
var offset = Vector2(0, 50)
var time = 0
var timeDirection = 1
var moveDuration = 2
func _ready():
	initpos = position
	topos = position + offset
	
func _process(delta):
	
	if time > moveDuration or time < 0:
		timeDirection *= -1
		
	time += delta * timeDirection
	var t = time / moveDuration
	
	position = lerp(initpos,topos, t)
