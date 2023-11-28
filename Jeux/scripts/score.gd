extends Label
var score = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Méthode pour changer le contenu du label
func set_label_content(new_content: String):
	text = new_content
