extends Area2D

export(int) var max_health = 5
export(float) var recharge_rate = 0.5
export(Color) var color = Color.blue

var recharge = 0
var health = max_health
var enabled = false

func _process(delta):
	if health < max_health:
		recharge += delta
		if recharge >= recharge_rate:
			health += 1
	else:
		recharge = 0
		
func _draw():
	print(enabled)
	if enabled:
		draw_arc(Vector2.ZERO, 35, 0, TAU, 360, color)

func damage(amount):
	health = max(0, health - amount)
	recharge = 0

func toggle(value):
	self.enabled = value
	update()


	
