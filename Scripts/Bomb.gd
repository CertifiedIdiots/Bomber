extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
@export var time: float = 1.5
@export var radius: int = 50
@export var color: Color = Color.DARK_TURQUOISE
@export var explosion: PackedScene
var drawn_radius = 0
	
func _draw():
	draw_arc(Vector2.ZERO, drawn_radius, 0, TAU, 100, color, 5)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 100, Color.RED, 5)

func _process(delta):
	time -= delta
	drawn_radius = min(radius, drawn_radius + delta * (radius / 1.5))
	
	if time <= 0:
		explode()
		
func explode():
	color = Color.TRANSPARENT
	var instance:Node2D = explosion.instantiate()
	instance.position = self.position
	instance.init("enemy", radius)
	get_parent().add_child(instance)
	queue_free()
