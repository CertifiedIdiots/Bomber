extends Area2D

export(Color) var color = Color.red

func _draw():
	draw_arc(Vector2.ZERO, 100, 0, TAU, 100, color)

func _on_Timer_timeout():
	queue_free()

func _on_Explosion_body_entered(body):
	if body.name.begins_with("Enemy"):
		body.queue_free()
