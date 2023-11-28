extends CharacterBody2D

var speed = 200

# Called when the node enters the scene tree for the first time.
func _ready():
	$fleche.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision = move_and_collide(velocity * delta)
	
func start(_position, _direction):
	rotation = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)


func _on_area_2d_body_entered(body):
	queue_free()
	if body.is_in_group("boss"):
		body.take_damage(10)
	if body.is_in_group("enemie"):
		body.take_damage(10)
