extends Node

class_name Item

var item_name:String
var item_description:String

func _init(givenname:String):
	item_name=givenname
#	item_description=givendescription

func _status():
#	var status = item_name + " - "+ item_description
	var status = item_name
	return status
