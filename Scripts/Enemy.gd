extends KinematicBody2D

export(float) var health = 100
export(int) var speed = 100


func _physics_process(delta):
	var player = get_parent().get_node("Player")
	if player == null:
		return
		
	var difference = (player.position - self.position)
	if difference.length() < 20:
		attack()
		
	move_and_slide(difference.normalized() * speed)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Player":
			collision.collider.queue_free()

func attack():
	pass
	
func damage(damage: float):
	health -= damage
	print("dealt " + str(damage) + " damage!")
	
	if health <= 0:
		queue_free()
	return
	

