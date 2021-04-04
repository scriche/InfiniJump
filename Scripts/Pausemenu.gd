extends Control

onready var game = $"../Game"

func _ready():
	pass

func _on_Button_toggled(button_pressed):
	game.get_tree().paused = button_pressed
