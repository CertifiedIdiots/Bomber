extends "Living.gd"

export(int) var speed = 100
var attack_range = 70
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
	elif not stunned:
		stunned = 1.0
		attack(get_parent().get_node("Player"))

func get_distance_to_player():
	var player = get_parent().get_node("Player")
	if player == null:
		return Vector2.ZERO
	
	return (player.position - self.position)

func attack(target):
	var instance:Node2D = attack_scene.instance()
	instance.position = self.position
	instance.attack_area( Vector2(10, attack_range) )
	get_parent().add_child(instance)
#	print(instance.position)

