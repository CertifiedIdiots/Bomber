extends "Living.gd"

@export var speed: int = 80
var attack_range = 60
var attack_cooldown = 0
var dash_length = 100.0
var last_dash = null
var damaging = false
var friction = 0.1
var endpoint = null
var direction = null
var pushable = true

var attack_scene = preload("res://Objects/Attack.tscn")

func _ready():
	self.health = 200

func _physics_process(delta):
	var distance = get_distance_to_player()
	
	if self.stunned > 0:
		velocity = lerp(velocity, Vector2.ZERO, friction)
		set_velocity(velocity)
		set_up_direction(Vector2.ZERO)
		set_floor_stop_on_slope_enabled(false)
		set_max_slides(1)
		move_and_slide()
		velocity = velocity
	elif distance.length() > attack_range:
		velocity = distance.normalized() * speed
		set_velocity(velocity)
		move_and_slide()
		velocity = velocity
	elif not super.is_stunned() and distance.length() <= attack_range:
		attack(get_parent().get_node("Player"))

	attack_cooldown = max(0, attack_cooldown - delta)

func attack(player):
	return

func get_distance_to_player():
	var player = get_parent().get_node("Player")
	if player == null:
		return Vector2.ZERO
	
	return (player.global_position - self.global_position)

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
