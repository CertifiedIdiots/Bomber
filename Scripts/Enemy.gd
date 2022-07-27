extends "Living.gd"

export(int) var speed = 80
var attack_range = 90
var attack_cooldown = rand_range(2.5, 5.0)
var dash_length = 120.0
const friction = 0.1



var attack_scene = preload("res://Objects/Attack.tscn")

func _ready():
	self.health = 200

func _physics_process(delta):
	var distance = get_distance_to_player()
	
	if stunned:
		movement = lerp(movement, Vector2.ZERO, friction)
		movement = move_and_slide(movement, Vector2.ZERO, false, 1)
	elif distance.length() > attack_range:
		movement = distance.normalized() * speed
		movement = move_and_slide(movement)
	elif not stunned and distance.length() <= attack_range:
		attack(get_parent().get_node("Player"))


	attack_cooldown = max(0, attack_cooldown - delta)
#	self.windup = max(0, self.windup - delta)

func get_distance_to_player():
	var player = get_parent().get_node("Player")
	if player == null:
		return Vector2.ZERO
	
	return (player.global_position - self.global_position)
	
#func windup(time):
#	self.stunned = time
#	$Sprite/Tween.interpolate_property(self, "position", Vector2())

func dash_attack():
	var player = get_parent().get_node("Player")
	var direction = player.global_position - self.global_position
	var endpoint = direction.normalized() * dash_length
	$CollisionShape2D.disabled = true
	$Tween.interpolate_property(self, "position", self.position, endpoint, 0.4, Tween.TRANS_LINEAR, Tween.EASE_OUT)
#	print(endpoint)
#	print(player.position)
	
	$Tween.start()
#	$CollisionShape2D.disabled = false
	
func attack(target):
	var cooldown = attack_cooldown
#	self.windup(0.3)
	if cooldown <= 0:
		stunned = 1.0
		dash_attack()
		cooldown = rand_range(2.5, 5.0)
#		print(target.position)
		
	
	
#	var instance:Node2D = attack_scene.instance()
#	instance.position = self.position
#	instance.attack_area( Vector2(10, attack_range) )
#	get_parent().add_child(instance)
#	print(instance.position)
