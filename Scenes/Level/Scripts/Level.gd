extends Node2D

func _input(event):
	if Input.is_action_pressed("restart"):
		get_tree().reload_current_scene()