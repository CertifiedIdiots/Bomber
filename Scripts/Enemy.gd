extends "Living.gd"

export(int) var speed = 80
var attack_range = 60
var attack_cooldown = 0
var dash_length = 100.0
var last_dash = null
var damaging = false
var friction = 0.1
var endpoint = null

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
	var direction_range = direction.normalized()
	endpoint = self.position + direction.normalized() * dash_length
	self.last_dash = self.position
	damaging = true
	$Tween.interpolate_property(self, "position", self.position, endpoint, 0.3, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
	$Tween.start()

func attack(target):
	var player = get_parent().get_node("Player")
	var direction = player.global_position - self.global_position
	if attack_cooldown <= 0:
		$Sprite.modulate = Color(1, 0, 0)
		stunned = 1.5
		yield(get_tree().create_timer(1.0), "timeout")
		dash_attack()
		attack_cooldown = rand_range(2.0, 4.0)
		$Sprite.modulate = Color.white
		damaging = false

#func _on_Tween_tween_completed(object, key):
#	if last_dash != null:
#		$Tween.interpolate_property(self, "position", self.position, last_dash, 0.2, Tween.TRANS_QUAD, Tween.EASE_IN_OUT)
#		$Tween.start()
#		$Sprite.modulate = Color.white
#		last_dash = null
#		damaging = false

func _on_DamageShape_body_entered(body):
	if body.is_in_group("player"):
		body.damage(50)
