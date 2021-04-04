extends Area2D
func _ready():
	pass

func _on_Boost_body_entered(body):
	if body.get_name() == "Player":
		body.jumps += 1
	get_tree().queue_delete(self)
