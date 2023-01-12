extends Node

class_name AllQuests

var questarray:Array

func _init(givenarray:Array):
	questarray=givenarray

func _showAll():
	var i = 0
	var result = ""
	for each in questarray:
		result = result + questarray[i]._status() +"\n"
		i=i+1
	return result

func _showStatus(givencode:String):
	var i =0
	var status
	for each in questarray:
		if questarray[i].questcode == givencode:
			status = questarray[i]._status()
		i = i+1
	
	return status

func _getQuest(givencode:String):
	var i =0
	var returnquest
	for each in questarray:
		if questarray[i].questcode == givencode:
			returnquest = questarray[i]
		i = i+1
	
	return returnquest

func _showActiveQuest():
	var i = 0
	var result = ""
	for each in questarray:
		if questarray[i].unlocked == true and questarray[i].claimed == false:
			result = result + questarray[i]._progress() +"\n"
		i=i+1
	
	if result == "":
		result = "No active quest"
	return result
