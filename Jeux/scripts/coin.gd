class_name Piece extends Node2D

signal piece_recup()

# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D/AnimatedSprite2D.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_area_2d_body_entered(body):
	collect_piece()
	queue_free()
	
func collect_piece():
	# Autres actions liées à la collecte de la pièce
	# Émettre le signal de pièce collectée
	emit_signal("piece_recup")
