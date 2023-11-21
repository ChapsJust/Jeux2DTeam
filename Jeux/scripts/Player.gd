extends CharacterBody2D

var vie = 99;
var speed = 80

func get_input():
	var input_direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = input_direction * speed
	
	#animation
	if Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("idle_front")
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("idle_back")
		
func _physics_process(delta):
	get_input()
	move_and_slide()
	update_health()
	
	if vie <= 0 :
		print("le personnage est mort")
		self.queue_free()
		
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
	
	
