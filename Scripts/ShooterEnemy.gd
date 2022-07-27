extends "res://Scripts/Enemy.gd"

func _ready():
	self.health = 150
	self.attack_range = 200
	self.attack_scene = preload("res://Objects/Projectile.tscn")

func attack(target):
	if stunned > 0: 
		return
	var instance:Node2D = self.attack_scene.instance()
	instance.init(self, target)
	instance.position = self.position
	get_parent().add_child(instance)
	self.stunned = 1.5
