extends CharacterBody2D

var vie = 100;
var speed = 80
var last_direction = "idle_front"
var test = true
func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var anim = $AnimatedSprite2D
	velocity = input_direction * speed
	
	#animation
	if  Input.is_action_just_pressed("souris") and test:
		$Attack_anim.visible = true
		$Attack_anim.play("attack_side")
		test = false
	else:
		$Attack_anim.visible = false
	if Input.is_action_pressed("ui_down"):
		anim.play("walk_front")
		last_direction = "idle_front"
	elif Input.is_action_pressed("ui_up"):
		anim.play("walk_back")
		last_direction = "idle_back"
	elif Input.is_action_pressed("ui_right"):
		anim.flip_h = false
		anim.play("walk_side")
		last_direction = "idle_side"
	elif Input.is_action_pressed("ui_left"):
		anim.flip_h = true
		anim.play("walk_side")
		last_direction = "idle_side"
	elif velocity == Vector2.ZERO:
		anim.play(last_direction)
	else:
		anim.play(last_direction)
		
		
func _physics_process(delta):
	get_input()
	move_and_slide()
	update_health()
	
	if vie <= 0 :
		print("le personnage est mort")
		self.queue_free()
		get_tree().change_scene_to_file("res://Scene/game_over.tscn")
# il faut créer ennemie
func update_health():
	var lifebar = $lifebar
	lifebar.value = vie
	
	# faire afficher la vie si on prend du dommage
	if vie >= 100 :
		lifebar.visible = false
	else :
		lifebar.visible = true


func _on_area_2d_body_entered(body):
	if body is Enemie:
		print("salut")
		print(vie)
		vie = vie - 10
		print(vie)


func _on_attack_anim_animation_finished():
	test = true


func _on_timer_anim_timeout():
	pass # Replace with function body.
