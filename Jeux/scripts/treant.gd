extends CharacterBody2D

var speed = 25
var vie_ennemie = 150
var player_target : Object

func _on_detection_body_entered(body):
	if body.is_in_group("player"):
		player_target = body

func _physics_process(delta):
	if player_target:
		look_at(player_target.global_position)
		var direction = global_transform.basis_xform(Vector2(1, 0)).normalized()
		velocity = direction * speed
		move_and_slide()
	if vie_ennemie <= 0:
		queue_free()
	lifebar()

func _on_detection_body_exited(body):
	player_target = null

func take_damage(damage_amount):
	vie_ennemie -= damage_amount
	print(vie_ennemie)

func lifebar():
	var lifebar = $lifebar
	lifebar.value = vie_ennemie
	# faire afficher la vie si on prend du dommage
	if vie_ennemie >= 150 :
		lifebar.visible = false
	else :
		lifebar.visible = true
