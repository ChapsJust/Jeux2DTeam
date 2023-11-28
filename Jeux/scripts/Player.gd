class_name Player extends CharacterBody2D

@export var fleche : PackedScene
var vie = 100;
var speed = 80
var last_direction = "idle_front"
var directions = "front"
var test = true
var can_attack = true
var num_coin = 0

func _ready():
	$Attack_Sword/Attack_anim.visible = false
	get_node("Attack_Sword/CollisionShape2D").disabled = true
	$Arc_Shoot.visible = false

func _physics_process(delta):
	get_input()
	move_and_slide()
	update_health()
	
func get_input():
	var anim_player = $AnimatedSprite2D

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
	attaque_sword()
	tire_arc()
		
func attaque_sword():
	#Les input de l'attaque et de l'area 2d
	var attack = $Attack_Sword
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

func tire_arc():
	var arc = $Arc_Shoot/Sprite2D
	var marker = $Arc_Shoot/Sprite2D/Marker2D
	if Input.is_action_just_pressed("arc") and can_attack:
		if directions == "right":
			arc.position = Vector2(48, 3)
			arc.flip_h = false
			marker.rotation_degrees = 0
		elif directions == "front":
			arc.position = Vector2(40, 21)
			marker.rotation_degrees = 90
		elif directions == "back":
			arc.position = Vector2(38, -10)
			marker.rotation_degrees = 270
		elif directions == "left":
			arc.position = Vector2(32, 3)
			arc.flip_h = true
			marker.rotation_degrees = 180
		can_attack = false
		$Arc_Shoot.visible = true
		shoot_arrow(arc.position, arc.flip_h)
		$Arc_Shoot/arc_cooldown.start()

func shoot_arrow(arrow_position, flip_arrow):
	var f = fleche.instantiate()
	f.start($Arc_Shoot/Sprite2D/Marker2D.global_position, $Arc_Shoot/Sprite2D/Marker2D.global_rotation)
	get_tree().root.add_child(f)

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
		vie = vie - 10
		print(vie)

func _on_attack_anim_animation_finished():
	$Attack_Sword/Attack_anim.visible = false
	get_node("Attack_Sword/CollisionShape2D").disabled = true
	can_attack = true


func _on_arc_cooldown_timeout():
	$Arc_Shoot.visible = false
	can_attack = true

func _on_attack_sword_body_entered(body):
	if body.is_in_group("boss"):
		body.take_damage(15)
	if body.is_in_group("enemie"):
		body.take_damage(15)
		

func _on_area_2d_area_entered(area):
	if area.is_in_group("coin"):
		num_coin = num_coin + 1
		$Coin_UI/num_coin.text = str(num_coin)
		$Coin_UI/coin.play()
		print(num_coin)

