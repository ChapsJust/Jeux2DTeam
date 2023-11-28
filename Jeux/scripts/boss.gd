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
	lifebar()

func bruitage():
	print(vie_boss)
	if vie_boss <= 400 and vie_boss >= 380:
		$cantkillme.play()
	elif vie_boss <= 300 and vie_boss >= 290:
		$imthegod.play()
	elif vie_boss <= 150 and vie_boss >= 130:
		$shalldie.play()
	elif  vie_boss <= 0:
		get_node("CollisionShape2D").call_deferred("set_disabled", true)
		$comeback.play()


func _on_comeback_finished():
	queue_free()

func lifebar():
	var lifebar = $lifebar
	lifebar.value = vie_boss
	
	# faire afficher la vie si on prend du dommage
	if vie_boss >= 500 :
		lifebar.visible = false
	else :
		lifebar.visible = true
