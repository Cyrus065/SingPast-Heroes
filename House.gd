extends Node2D

signal go_exploration

func _on_Transition_go_exploration():
	emit_signal("go_exploration")
