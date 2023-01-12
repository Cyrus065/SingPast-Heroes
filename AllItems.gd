extends Node

class_name AllItems

var itemarray:Array

func _init(givenarray:Array):
	itemarray=givenarray

func _showAll():
	if itemarray.empty():
		return "Bag is empty"
	
	var i = 0
	var result = ""
	for each in itemarray:
		result = result + itemarray[i]._status() +"\n"
		i=i+1
	return result

func _addItem(givenname:String):
	var item = Item.new(givenname)
	itemarray.append(item)

func _minusItem(givenname:String):
	var i =0
	for each in itemarray:
		if itemarray[i].item_name == givenname:
			itemarray.erase(itemarray[i])

func _hasItem(givenname:String):
	var i =0
	for each in itemarray:
		if itemarray[i].item_name == givenname:
			return true
	return false
