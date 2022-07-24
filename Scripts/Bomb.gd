extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var time = 1.5
export(int) var radius = 50
export(Color) var color = Color.darkturquoise
export(PackedScene) var explosion

# Called when the node enters the scene tree for the first time.
func _ready():
	update()
	
#func _draw():
#	draw_circle(Vector2.ZERO, 30, color)

func _process(delta):
	time -= delta
	if time <= 0:
		explode()
		
func explode():
	color = Color.transparent
	var instance:Node2D = explosion.instance()
	instance.position = self.position
	instance.update_radius(radius)
	get_parent().add_child(instance)
	queue_free()
