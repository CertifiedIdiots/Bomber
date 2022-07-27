extends "Living.gd"

export(int) var speed = 80
var attack_range = 40
var attack_cooldown = rand_range(2.5, 5.0)
var dash_length = 20.0
var last_dash = null
const friction = 0.1

var attack_scene = preload("res://Objects/Attack.tscn")

func _ready():
	self.health = 200

func _physics_process(delta):
	var distance = get_distance_to_player()
	
	if stunned:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		velocity = move_and_slide(velocity, Vector2.ZERO, false, 1)
	elif distance.length() > attack_range:
		velocity = distance.normalized() * speed
		velocity = move_and_slide(velocity)
	elif not stunned and distance.length() <= attack_range:
		attack(get_parent().get_node("Player"))

	attack_cooldown = max(0, attack_cooldown - delta)

func get_distance_to_player():
	var player = get_parent().get_node("Player")
	if player == null:
		return Vector2.ZERO
	
	return (player.global_position - self.global_position)

func dash_attack():
	var player = get_parent().get_node("Player")
	var direction = player.global_position - self.global_position
	var endpoint = self.position + direction.normalized() * dash_length
	self.last_dash = self.position
	$Tween.interpolate_property(self, "position", self.position, endpoint, 0.2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()
	
func attack(target):
	var cooldown = attack_cooldown
	if cooldown <= 0:
		stunned = 1.0
		dash_attack()
		cooldown = rand_range(2.5, 5.0)


func _on_Tween_tween_completed(object, key):
	if last_dash != null:
		$Tween.interpolate_property(self, "position", self.position, last_dash, 0.2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
		$Tween.start()
		last_dash = null
