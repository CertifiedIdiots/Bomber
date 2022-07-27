extends "Living.gd"

export(int) var speed = 100
var attack_range = 70
var attack_cooldown = 3.0
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
	
	return (player.position - self.position)
	
func _on_Area2D_body_entered(body: Node):
	if self.is_dashing():
		body.damage(50)
	
func windup(time: float):
	stunned = time
#	$Sprite/Tween.interpolate_property(self, "position", Vector2())

func dash_attack():
	self.dashing = true
	print("enemey dash")
	self.dashing = false
	
func attack(target):
	var cooldown = attack_cooldown
	self.windup(0.3)
	if cooldown <= 0:
		stunned = 1.0
		self.dash_attack()
		cooldown = 3.0
	
		
	
	
#	var instance:Node2D = attack_scene.instance()
#	instance.position = self.position
#	instance.attack_area( Vector2(10, attack_range) )
#	get_parent().add_child(instance)
#	print(instance.position)
