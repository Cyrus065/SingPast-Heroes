extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func speak():
	var dialog = Dialogic.start("1965")
	add_child(dialog)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
