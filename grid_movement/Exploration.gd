extends Node2D

signal go_house

func _on_Transition_go_house():
	emit_signal("go_house")
