extends "Living.gd"

export(int) var speed = 100
const friction = 0.1

func _ready():
	self.health = 200

func _physics_process(delta):
	if stunned:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		velocity = move_and_slide(velocity, Vector2.ZERO, false, 1)
	else:
		velocity = get_velocity_to_player()
		velocity = move_and_slide(velocity)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider && collision.collider.name == "Player":
			collision.collider.queue_free()

func get_velocity_to_player():
	var player = get_parent().get_node("Player")
	if player == null:
		return Vector2.ZERO
		
	var difference = (player.position - self.position)
	if difference.length() < 20:
		attack()
		
	return difference.normalized() * speed

func attack():
	pass
	

