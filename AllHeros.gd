extends Node

class_name AllHeros

var heroarray:Array

func _init(givenarray:Array):
	heroarray=givenarray

func _showAll():
	if heroarray.empty():
		return "No contact is found"
	
	var i = 0
	var result = ""
	for each in heroarray:
		result = result + heroarray[i]._status() +"\n"
		i=i+1
	return result

func _addItem(givenname:String):
	var item = Item.new(givenname)
	heroarray.append(item)

func _minusItem(givenname:String):
	var i =0
	for each in heroarray:
		if heroarray[i].hero_name == givenname:
			heroarray.erase(heroarray[i])

func codeForHero(givencode:String):
	var i =0
	for each in heroarray:
		if each.hero_code == givencode:
			return each
		i+i+1
		
func nameForHero(givenname:String):
	var i =0
	for each in heroarray:
		if each.hero_name == givenname:
			return each
		i+i+1

func _sixHeros():
	var result = []
	var i = 0
	for each in heroarray:
		result.append(heroarray[i])
		i=i+1
	return result
