extends KinematicBody2D

signal charge_bomb

var velocity = Vector2.ZERO
# whether player is holding a bomb that is fully charged
var bomb_ready = false
var charge = 0

# time in seconds to fully charge bomb
export(float) var charge_time = 0.5
# player move speed in pixels/second
export(int) var move_speed = 160
export(PackedScene) var placed_bomb

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	var charging = Input.is_action_pressed("charge_bomb")
	if charging and not bomb_ready:
		charge += delta
	if not charging or bomb_ready:
		charge = 0
	if charge > charge_time:
		bomb_ready = true
		print("Bomb Ready!")
	elif not charging and bomb_ready:
		emit_signal("charge_bomb")
		var bomb = placed_bomb.instance()
		bomb.position = self.position
		get_parent().add_child(bomb)
		print("Bomb placed!")
		bomb_ready = false

# old function
#	if bomb_ready and charging:
#		charge += delta
#	elif not bomb_ready and charging:
#		charge = delta
#	elif bomb_ready and not charging:
#		if charge > charge_time:
#			print("Bomb placed!")
#			emit_signal("charge_bomb")
#			var bomb = placed_bomb.instance()
#			bomb.position = self.position
#			get_parent().add_child(bomb)
#		charge = 0	
#	bomb_ready = charging


func _physics_process(delta):
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
	velocity = move_and_slide(velocity)
	look_at(get_global_mouse_position())

