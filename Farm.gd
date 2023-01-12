extends Node2D

signal close_farm

func _input(event):
	if event.is_action_pressed("ui_bag"):
		emit_signal("close_farm")
