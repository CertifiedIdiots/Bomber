extends "res://Scripts/Enemy.gd"

func _ready():
	self.health = 150
	self.attack_range = 300
	self.attack_scene = preload("res://Objects/Projectile.tscn")
	self.pushable = false

func attack(target):
	if super.is_stunned(): 
		return
	
	$Sprite2D.modulate = Color(1, 0, 0)
	stunned = 1.5
	await get_tree().create_timer(0.5).timeout
	var instance:Node2D = self.attack_scene.instantiate()
	instance.init(self, target)
	instance.position = self.position
	get_parent().add_child(instance)
	self.stunned = 1.5
	$Sprite2D.modulate = Color.WHITE
