extends Area2D

export(float) var radius = 50.0
export(Color) var color = Color.red
var target = "none"

var center = Vector2.ZERO

func init(target, radius):
	self.target = target
	self.radius = radius
	$CollisionShape2D.shape.radius = radius

func _draw():
	draw_arc(center, radius, 0, TAU, 360, color)

func _on_Timer_timeout():
	queue_free()

func _on_Explosion_body_entered(body: Node):
	if body.is_in_group(self.target):
		body.damage(50)
		body.stunned = 0.5
		body.velocity = (body.position - self.position) * 5

