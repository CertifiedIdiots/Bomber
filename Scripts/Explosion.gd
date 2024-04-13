extends AnimatedSprite2D

@export var radius: float = 50.0
@export var color: Color = Color.RED
var target = "none"

var center = Vector2.ZERO

func init(target, radius):
	self.target = target
	self.radius = radius
	get_node("Explosion/Shape3D").shape.radius = radius

func _ready():
	self.play()

func _on_Explosion_body_entered(body: Node):
	if body.is_in_group(self.target):
		body.damage(50)
		if body.pushable:
			body.stunned = 0.5
			body.velocity = (body.position - self.position) * 5

func _on_AnimatedSprite_animation_finished():
	queue_free()
