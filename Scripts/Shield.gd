extends Area2D

export(int) var max_health = 250
export(float) var recharge_rate = 2
export(Color) var color = Color.blue
export(float) var radius = 25

var recharge = 0
var health = max_health
var enabled = false
var alive = true

func _process(delta):
	if health < max_health && alive:
		recharge += delta
		if recharge >= recharge_rate:
			health += 50
			recharge = 0
			update()
	else:
		recharge = 0

func _draw():
	if enabled && alive:
		var color = Color.blue
		if health <= 50:
			color = Color.crimson
		elif health <= 100:
			color = Color.coral
		elif health <= 150:
			color = Color.yellow
		elif health <= 200:
			color = Color.aquamarine
		$CollisionShape2D.shape.radius = radius
		draw_arc(Vector2.ZERO, radius, 0, TAU, 360, color, 4)

func damage(amount):
	health = max(0, health - amount)
	recharge = 0
	if health <= 0:
		$DeathTimer.paused = false
		$DeathTimer.start(8)
		alive = false
	update()

func toggle(value):
	enabled = value
	if enabled && alive:
		push_enemies()
	update()

func push_enemies():
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy") and body.pushable:
			body.stunned = 0.5
			var force = (body.position - get_parent().position).normalized() * 100
			body.velocity = force * 5

func _on_DeathTimer_timeout():
	alive = true
