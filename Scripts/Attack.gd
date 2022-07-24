extends Area2D

export(Color) var color = Color.red

func _draw():
	var start_pos = $AttackShape.position
	start_pos = get_parent().position
	draw_rect(Rect2(start_pos, $AttackShape.shape.extents), color)

	print($AttackShape.position)
#	print($AttackShape.shape.extents)

func _on_Attack_body_entered(body):
	if body.name.begins_with("Player"):
		body.damage(50)
		print(body.health)
		body.velocity = (body.position - self.position) * 10
		
func attack_area(area):
	$AttackShape.shape.extents = area
		
func _on_Timer_timeout():
	queue_free()
