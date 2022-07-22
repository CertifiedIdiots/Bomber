extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(float) var time = 1.5
export(Color) var color = Color.darkturquoise
export(PackedScene) var explosion


# Called when the node enters the scene tree for the first time.
func _ready():
	print(self.position)
	update()
	
#func _draw():
#	draw_circle(Vector2.ZERO, 30, color)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time -= delta
	if time <= 0:
		explode()
		
func explode():
	color = Color.transparent
	var instance = explosion.instance()
	instance.position = self.position
	get_parent().add_child(instance)
	queue_free()
