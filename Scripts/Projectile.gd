extends Area2D

@export var speed: int = 10
@export var velocity: Vector2 = Vector2.ZERO
var target = "none"

func init(launcher: CharacterBody2D, target: Node2D):
	self.velocity = (target.position - launcher.position).normalized() * speed
	self.position =  launcher.position + self.velocity.normalized() * 5
	self.target = target.get_groups().front()

func _physics_process(delta):
	position += velocity * speed * delta

func _draw():
	draw_circle(Vector2.ZERO, 10, Color.ORANGE)

func _on_Projectile_body_entered(body: Node):
	if body.is_in_group(self.target):
		body.damage(50)
		queue_free()
	if body is TileMap:
		queue_free()
