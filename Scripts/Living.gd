extends CharacterBody2D

@export var health: int = 100
var stunned = 0
var dashing = false

func _init():
	velocity = Vector2.ZERO

func _process(delta):
	print("In living: ", self.stunned)
	self.stunned = max(0, stunned - delta)

func damage(amount: float):
	if has_node("Shield") && $Shield.enabled && $Shield.health > 0:
		$Shield.damage(amount)
	else:
		self.health -= amount
		if self.health <= 0:
			die()

func die():
	queue_free()

func stun(time):
	self.stunned = time
	print("GETTING STUNNED:", self.stunned)

func is_stunned():
	print("Am I stunned?", self.stunned)
	return self.stunned > 0
