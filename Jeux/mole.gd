class_name Enemie extends CharacterBody2D


var speed = 100  # Vitesse de déplacement de l'ennemi
var target = null  # Cible du mouvement (le joueur)

func _process(delta):
	if target:
		
		print("salut")
		# Calculer la direction vers la cible
		var direction = (target.global_position - global_position).normalized()
		print(direction)
		# Déplacer l'ennemi vers la cible
		move_and_slide()


# quand je rentre dans le champ de vision
func _on_zone_de_détection_body_entered(body):
		if body is player:
			print("salut")
			target = body  # Le joueur est maintenant la cible

# quand je quitte le champ de vision
func _on_zone_de_détection_body_exited(body):
	if body is player:
		print("au revoir")
		target = null
