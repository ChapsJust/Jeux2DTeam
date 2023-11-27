extends CharacterBody2D

var vie = 100;
var speed = 80
var last_direction = "idle_front"
var directions = "front"
var test = true
var can_attack = true

func _ready():
	$Attack_Sword/Attack_anim.visible = false
	get_node("Attack_Sword/CollisionShape2D").disabled = true

func _physics_process(delta):
	get_input()
	move_and_slide()
	update_health()

func get_input():
	var anim_player = $AnimatedSprite2D
	var attack = $Attack_Sword

	#Les mouvement en 8-way
	var input_direction = Input.get_vector("A", "D", "W", "S")
	velocity = input_direction * speed
	
	#Tout se qui concerne le player
	if Input.is_action_pressed("S"):
		anim_player.play("walk_front")
		last_direction = "idle_front"
		directions = "front"
	elif Input.is_action_pressed("W"):
		anim_player.play("walk_back")
		last_direction = "idle_back"
		directions = "back"
	elif Input.is_action_pressed("D"):
		anim_player.flip_h = false
		anim_player.play("walk_side")
		last_direction = "idle_side"
		directions = "right"
	elif Input.is_action_pressed("A"):
		anim_player.flip_h = true
		anim_player.play("walk_side")
		last_direction = "idle_side"
		directions = "left"
	elif velocity == Vector2.ZERO:
		anim_player.play(last_direction)
	else:
		anim_player.play(last_direction)
		
	#Les input de l'attaque et de l'area 2d
	if Input.is_action_just_pressed("souris") and can_attack:
		attack.global_rotation = get_global_rotation()
		if directions == "right":
			attack.position = Vector2(16, 4)
			attack.rotation_degrees = 6.5
		elif directions == "front":
			attack.position = Vector2(-2, 18)
			attack.rotation_degrees = 96.9
		elif directions == "back":
			attack.position = Vector2(-2, -18)
			attack.rotation_degrees = 276.9
		elif directions == "left":
			attack.position = Vector2(-16, 4)
			attack.rotation_degrees = 186.5
		can_attack = false
		$Attack_Sword/Attack_anim.visible = true
		$Attack_Sword/Attack_anim.play("attack")
		get_node("Attack_Sword/CollisionShape2D").disabled = false
		$Slash.play()

#Rafraichie la vie et vérifie si mort
func update_health():
	var lifebar = $lifebar
	lifebar.value = vie
	
	# faire afficher la vie si on prend du dommage
	if vie >= 100 :
		lifebar.visible = false
	else :
		lifebar.visible = true

	#Vérifie si mort si oui mort affiche le game over
	if vie <= 0 :
		print("le personnage est mort")
		self.queue_free()
		get_tree().change_scene_to_file("res://Scene/game_over.tscn")

func _on_area_2d_body_entered(body):
	if body is Enemie:
		print("salut")
		print(vie)
		vie = vie - 10
		print(vie)

func _on_attack_anim_animation_finished():
	$Attack_Sword/Attack_anim.visible = false
	get_node("Attack_Sword/CollisionShape2D").disabled = true
	can_attack = true
