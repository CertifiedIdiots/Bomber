extends KinematicBody2D

export(int) var speed = 100

func _physics_process(delta):
	var player = get_parent().get_node("Player")
	if player == null:
		return
	var direction = (player.position - self.position).normalized()
	print(direction)
	move_and_slide(direction * speed)
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player":
			collision.collider.queue_free()
