extends Area2D

export(float) var radius = 50.0
export(Color) var color = Color.red

var center = Vector2.ZERO

func _draw():
	draw_arc(center, radius, 0, TAU, 360, color)

func _on_Timer_timeout():
	queue_free()

func _on_Explosion_body_entered(body):
	if body.name.begins_with("Enemy"):
		body.damage(50)
		body.stunned = 0.5
		body.velocity = (body.position - self.position) * 10

func update_radius(radius):
	self.radius = radius
	self.get_node("CollisionShape2D").shape.radius = radius
