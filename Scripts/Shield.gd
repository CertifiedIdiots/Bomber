extends Area2D

export(int) var max_health = 250
export(float) var recharge_rate = 2
export(Color) var color = Color.blue

var recharge = 0
var health = max_health
var enabled = false

func _process(delta):
	if health < max_health:
		recharge += delta
		if recharge >= recharge_rate:
			health += 50
			recharge = 0
			update()
	else:
		recharge = 0
		
func _draw():
	if enabled:
		var color = Color.blue
		if health <= 50:
			color = Color.crimson
		elif health <= 100:
			color = Color.coral
		elif health <= 150:
			color = Color.yellow
		elif health <= 200:
			color = Color.aquamarine
		draw_arc(Vector2.ZERO, 35, 0, TAU, 360, color, 5)

func damage(amount):
	health = max(0, health - amount)
	recharge = 0
	update()

func toggle(value):
	self.enabled = value
	update()


	
