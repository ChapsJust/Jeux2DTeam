extends Control



func _on_lancer_pressed():
	get_tree().change_scene_to_file("res://Scene/level/Main.tscn")


func _on_tuto_pressed():
	get_tree().change_scene_to_file("res://Scene/level/tuto.tscn")
