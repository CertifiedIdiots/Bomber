extends "Living.gd"

signal charge_bomb

# whether player is holding a bomb that is fully charged
var bomb_ready = false
var charge = 0
var type = "player"

# time in seconds to fully charge bomb
export(float) var charge_time = 0.5
# player move speed in pixels/second
export(int) var move_speed = 160
export(PackedScene) var placed_bomb

func _process(delta):
	processBomb(delta)
	processShield()
	look_at(get_global_mouse_position())

func processBomb(delta):
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
		stunned = 0.3

func processShield():
	if Input.is_action_just_pressed("shield"):
		get_node("Shield").toggle(true)
	if Input.is_action_just_released("shield"):
		get_node("Shield").toggle(false)

func _physics_process(delta):
	if stunned:
		movement = Vector2.ZERO
	else:
		movement = Input.get_vector("move_left", "move_right", "move_up", "move_down") * move_speed
		if Input.is_action_pressed("shield"):
			movement /= 2
	movement = move_and_slide(movement)


