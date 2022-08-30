extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var time = 1.5
export(int) var radius = 50
export(Color) var color = Color.darkturquoise
export(PackedScene) var explosion
var drawn_radius = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	update()
	
func _draw():
	draw_arc(Vector2.ZERO, drawn_radius, 0, TAU, 100, color, 5)
	draw_arc(Vector2.ZERO, radius, 0, TAU, 100, Color.red, 5)

func _process(delta):
	time -= delta
	drawn_radius = min(radius, drawn_radius + delta * (radius / 1.5))
	update()
	if time <= 0:
		explode()
		
func explode():
	color = Color.transparent
	var instance:Node2D = explosion.instance()
	instance.position = self.position
	instance.init("enemy", radius)
	get_parent().add_child(instance)
	queue_free()
