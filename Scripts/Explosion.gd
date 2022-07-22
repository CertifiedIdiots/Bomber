extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export(Color) var color = Color.red

# Called when the node enters the scene tree for the first time.
func _ready():
	pass 

func _draw():
	draw_arc(Vector2.ZERO, 100, 0, TAU, 100, color)

func _on_Timer_timeout():
	queue_free()


func _on_Explosion_body_entered(body):
	if body is KinematicBody2D:
		body.queue_free()
