class_name Boss extends Node2D

var vie_boss = 500

func _ready():
	pass

func _process(delta):
	pass

func take_damage(damage_amount):
	vie_boss -= damage_amount
	print(vie_boss)
	bruitage()

func bruitage():
	print(vie_boss)
	if vie_boss <= 400 and vie_boss >= 380:
		$cantkillme.play()
		print("hey")
	elif vie_boss <= 300 and vie_boss >= 290:
		$imthegod.play()
	elif vie_boss <= 150 and vie_boss >= 130:
		$shalldie.play()
	elif  vie_boss <= 0:
		$comeback.play()


func _on_comeback_finished():
	queue_free()
