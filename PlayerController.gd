extends KinematicBody2D

signal bomb

var velocity = Vector2()
var bombing = false
var charge = 0

export (int) var charge_time = 2
export(int) var speed = 10
export(PackedScene) var bomb_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	var holding = Input.is_action_pressed("bomb")
	if bombing and holding:
		charge += delta
	elif not bombing and holding:
		charge = delta
	elif bombing and not holding:
		if charge > charge_time:
			print("bombed!")
			emit_signal("bomb")
			var bomb = bomb_scene.instance()
			bomb.position = self.position
			get_parent().add_child(bomb)
		charge = 0	
	bombing = holding


func _physics_process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * speed
	velocity = move_and_slide(velocity)
	look_at(get_global_mouse_position())

