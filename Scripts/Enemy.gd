extends "Living.gd"

export(int) var speed = 100
export(int) var attack_range = 70
const friction = 0.1


func _ready():
	self.health = 200

func _physics_process(delta):
	var distance = get_distance_to_player()
	if stunned:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		velocity = move_and_slide(velocity, Vector2.ZERO, false, 1)
	elif distance.length() > attack_range:
		velocity = distance.normalized() * speed
		velocity = move_and_slide(velocity)
	else:
		stunned = 0.5
		attack()
		print("attacked!")
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider && collision.collider.name == "Player":
			collision.collider.queue_free()

func get_distance_to_player():
	var player = get_parent().get_node("Player")
	var difference = (player.position - self.position)
	if player == null:
		return Vector2.ZERO
	return difference

func attack():
	
	pass
	

