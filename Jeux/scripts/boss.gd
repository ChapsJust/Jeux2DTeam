class_name Boss extends Node2D

var vie_boss = 500

func _ready():
	pass

func _process(delta):
	pass

func take_damage(damage_amount):
	vie_boss -= damage_amount
	print(vie_boss)

func bruitage():
	pass
