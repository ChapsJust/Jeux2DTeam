extends Control
# pour relancer le jeu ps: a modifier ses pas optimal
func _on_button_pressed():
	get_tree().change_scene_to_file("res://Scene/Main.tscn")
	print("yo")
