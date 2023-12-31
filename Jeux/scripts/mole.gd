class_name Enemie extends CharacterBody2D
var speed = 35
var vie_ennemie = 100
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

func _on_detection_body_exited(body):
	player_target = null

func take_damage(damage_amount):
	vie_ennemie -= damage_amount
	print(vie_ennemie)
