extends Area2D

@export var max_health: int = 250
@export var recharge_rate: float = 2
@export var color: Color = Color.BLUE
@export var radius: float = 25

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
	else:
		recharge = 0
	queue_redraw()

func _draw():
	if enabled && alive:
		var color = Color.BLUE
		if health <= 50:
			color = Color.CRIMSON
		elif health <= 100:
			color = Color.CORAL
		elif health <= 150:
			color = Color.YELLOW
		elif health <= 200:
			color = Color.AQUAMARINE
		$CollisionShape2D.shape.radius = radius
		draw_arc(Vector2.ZERO, radius, 0, TAU, 360, color, 4)

func damage(amount):
	health = max(0, health - amount)
	recharge = 0
	if health <= 0:
		$DeathTimer.paused = false
		$DeathTimer.start(8)
		alive = false

func toggle(value):
	enabled = value
	if enabled && alive:
		push_enemies()

func push_enemies():
	for body in get_overlapping_bodies():
		if body.is_in_group("enemy") and body.pushable:
			body.stunned = 0.5
			var force = (body.position - get_parent().position).normalized() * 100
			body.velocity = force * 5

func _on_DeathTimer_timeout():
	alive = true
