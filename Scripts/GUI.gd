extends RichTextLabel

func _process(delta):
	var player = get_parent().get_node("YSort/Player")
	self.text = "Health: " + str(player.health) + " Shield: " + str(player.get_node("Shield").health)
