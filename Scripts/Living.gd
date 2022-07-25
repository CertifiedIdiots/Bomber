extends KinematicBody2D

export(int) var health = 100
var stunned = 0
var velocity = Vector2.ZERO

func _process(delta):
	stunned = max(0, stunned - delta)

func damage(amount: float):
	if has_node("Shield") && $Shield.enabled && $Shield.health > 0:
		$Shield.damage(amount)
	else:
		self.health -= amount
		if self.health <= 0:
			die()

func die():
	queue_free()

func is_stunned():
	return stunned <= 0
